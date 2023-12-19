import React from "react";

export function Transfer({
  transferTokens,
  tokenSymbol1,
  tokenSymbol2,
  tokenSymbol3,
}) {
  return (
    <div>
      <h4>Transfer</h4>
      <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();

          const formData = new FormData(event.target);
          const to = formData.get("to");
          const amount1 = formData.get("amount1");
          const amount2 = formData.get("amount2");
          const price = formData.get("amount3");

          console.log(to, amount1, amount2, price);

          if (to && amount1 && amount2 && price) {
            transferTokens(to, amount1, amount2, price);
          }
        }}
      >
        <div className="form-group">
          <label>Amount of {tokenSymbol1}</label>
          <input
            className="form-control"
            type="number"
            step="1"
            name="amount1"
            placeholder="1"
            required
          />
        </div>
        <div className="form-group">
          <label>Amount of {tokenSymbol2}</label>
          <input
            className="form-control"
            type="number"
            step="1"
            name="amount2"
            placeholder="1"
            required
          />
        </div>
        <div className="form-group">
          <label>Amount of {tokenSymbol3}</label>
          <input
            className="form-control"
            type="number"
            step="1"
            name="amount3"
            placeholder="1"
            required
          />
        </div>
        <div className="form-group">
          <label>Recipient address</label>
          <input className="form-control" type="text" name="to" required />
        </div>
        <div className="form-group">
          <input className="btn btn-primary" type="submit" value="Transfer" />
        </div>
      </form>
    </div>
  );
}
