document.getElementById("cardPaymentForm").addEventListener("submit", function (e) {
    let valid = true;

    function showError(id, message) {
        document.getElementById(id).innerText = message;
        valid = false;
    }

    document.querySelectorAll(".error").forEach(el => el.innerText = "");

    const name = document.getElementById("cardholderName").value.trim();
    const card = document.getElementById("cardNumber").value.trim();
    const month = document.getElementById("expiryMonth").value;
    const year = document.getElementById("expiryYear").value;
    const cvv = document.getElementById("cvv").value.trim();
    const email = document.getElementById("billingEmail").value.trim();

    if (name === "") showError("nameError", "Cardholder name is required.");
    if (!/^[0-9]{16}$/.test(card)) showError("cardError", "Card number must be 16 digits.");
    if (month === "") showError("monthError", "Expiry month is required.");
    if (year === "") showError("yearError", "Expiry year is required.");
    if (!/^[0-9]{3}$/.test(cvv)) showError("cvvError", "CVV must be 3 digits.");
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) showError("emailError", "Enter a valid email.");

    if (!valid) e.preventDefault();
});