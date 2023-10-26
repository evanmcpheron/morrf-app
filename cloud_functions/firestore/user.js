const { onCall } = require("firebase-functions/v2/https");
require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const { logger } = require("firebase-functions");

const getStripeUser = onCall(async ({ data }) => {
    try {
        let customerId;
        // Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: data.email,
            limit: 1,
        });
        // Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[
                0
            ];
        } else {
            return {
                success: false, error: "This user doesn't exist.",
            };
        }

        return { success: true, payload: customerId };
    } catch (error) {
        logger.error({ getCards: error }, { structuredData: true });
        return {
            success: false, error: error.message,
        };
    }
});

const createStripeCustomer = onCall(async ({ data }) => {
    try {
        logger.info(data);
        const customer = await stripe.customers.create({
            email: data.email,
            name: data.name,
        });
        logger.info({ customer: customer.data });
        const customerId = customer.id;

        return { success: true, payload: customerId };
    } catch (error) {
        logger.error({ createStripeCustomer: error }, { structuredData: true });
        return {
            success: false, error: error.message,
        };
    }
});

module.exports = { getStripeUser, createStripeCustomer };