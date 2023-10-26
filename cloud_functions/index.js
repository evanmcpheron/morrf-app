// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");

const { getStripeUser, createStripeCustomer } = require("./firestore/user");
const { addStripeCard, getCards, updateDefaultCard, deleteCard } = require("./firestore/billing/card");

initializeApp();

module.exports = { getStripeUser, addStripeCard, getCards, createStripeCustomer, updateDefaultCard, deleteCard };
