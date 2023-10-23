const { onCall } = require("firebase-functions/v2/https");
require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const { logger } = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");

initializeApp();

exports.getStripeUser = onCall(async ({ data }) => {
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

exports.addStripeCard = onCall(async ({ data }) => {
    logger.info(data);
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
            ].id;
        } else {
            return {
                success: false, error: "This user doesn't exist.",
            };
        }

        const customer = customerList.data[0];
        logger.info({ customer: customer.invoice_settings });

        logger.info({ paymentMethod: data.paymentMethod });

        await stripe.paymentMethods.attach(
            data.paymentMethod,
            {
                customer: customerId,
            },
        );

        if (customer.invoice_settings.default_payment_method == null) {
            await stripe.customers.update(
                customerId,
                { invoice_settings: { default_payment_method: data.paymentMethod } },
            );
        }

        logger.info({
            addCard: data.paymentMethod,
        },
            {
                structuredData: true,
            });

        return { success: true, payload: data };
    } catch (error) {
        logger.error({
            addCard: error,
        },
            {
                structuredData: true,
            });
        return {
            success: false, error: error.message,
        };
    }
});

exports.getCards = onCall(async ({ data }) => {
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
            ].id;
        } else {
            return {
                success: false, error: "This user doesn't exist.",
            };
        }
        const paymentMethods = await stripe.customers.listPaymentMethods(
            customerId,
            {
                type: "card",
            },
        );

        logger.info({
            getCards: paymentMethods,
        },
            {
                structuredData: true,
            });

        return { success: true, payload: paymentMethods.data };
    } catch (error) {
        logger.error({ getCards: error }, { structuredData: true });
        return {
            success: false, error: error.message,
        };
    }
});

exports.createStripeCustomer = onCall(async ({ data }) => {
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