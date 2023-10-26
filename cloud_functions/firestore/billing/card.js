const { onCall } = require("firebase-functions/v2/https");
require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const { logger } = require("firebase-functions");

const addStripeCard = onCall(async ({ data }) => {
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
        const defaultPaymentMethod = customer.invoice_settings.default_payment_method;
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

        const paymentMethodDetails = await stripe.paymentMethods.retrieve(
            data.paymentMethod,
        );

        logger.info({
            addCard: paymentMethodDetails,
        },
            {
                structuredData: true,
            });

        const { id, card: { brand, exp_month, exp_year, last4, generated_from, funding, country } } = paymentMethodDetails;

        return { success: true, payload: { isDefault: defaultPaymentMethod == id, id, last4, funding, generatedFrom: generated_from, brand, expMonth: exp_month, expYear: exp_year, country } };
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

const updateDefaultCard = onCall(async ({ data }) => {
    logger.info({ data });
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

        logger.info({ paymentMethod: data.cardId });

        await stripe.customers.update(
            customerId,
            { invoice_settings: { default_payment_method: data.cardId } },
        );


        const paymentMethods = await stripe.customers.listPaymentMethods(
            customerId,
            {
                type: "card",
            },
        );

        const cards = [];

        logger.info({
            getCards: paymentMethods.data,
        },
            {
                structuredData: true,
            });

        // eslint-disable-next-line guard-for-in
        for (const card in paymentMethods.data) {
            logger.info({ currentCard: paymentMethods.data[card] });
            const { id, card: { brand, exp_month, exp_year, last4, generated_from, funding, country } } = paymentMethods.data[card];
            cards.push({ isDefault: data.cardId == id, id, last4, funding, generatedFrom: generated_from, brand, expMonth: exp_month, expYear: exp_year, country });
        }

        return { success: true, payload: cards };
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

const getCards = onCall(async ({ data }) => {
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

        const defaultPaymentMethod = customer.invoice_settings.default_payment_method;


        const paymentMethods = await stripe.customers.listPaymentMethods(
            customerId,
            {
                type: "card",
            },
        );

        const cards = [];

        logger.info({
            getCards: paymentMethods.data,
        },
            {
                structuredData: true,
            });

        // eslint-disable-next-line guard-for-in
        for (const card in paymentMethods.data) {
            logger.info({ currentCard: paymentMethods.data[card] });
            const { id, card: { brand, exp_month, exp_year, last4, generated_from, funding, country } } = paymentMethods.data[card];
            cards.push({ isDefault: defaultPaymentMethod == id, id, last4, funding, generatedFrom: generated_from, brand, expMonth: exp_month, expYear: exp_year, country });
        }

        return { success: true, payload: cards };
    } catch (error) {
        logger.error({ getCards: error }, { structuredData: true });
        return {
            success: false, error: error.message,
        };
    }
});

const deleteCard = onCall(async ({ data }) => {
    try {
        const paymentMethod = await stripe.paymentMethods.detach(
            data.cardId,
        );

        return { success: true, payload: paymentMethod };
    } catch (error) {
        logger.error({ getCards: error }, { structuredData: true });
        return {
            success: false, error: error.message,
        };
    }
});

module.exports = { addStripeCard, getCards, updateDefaultCard, deleteCard };