---
type: brief
engagement: fx-hedging
capability: fx-hedging
date: YYYY-MM-DD
status: committed          # committed | superseded
hypothesis: I expect the quoted forward (1.1705) to beat a money-market hedge (about 1.127) by roughly $270,000, because the quote sits well above interest-rate parity; the put's net floor (about $6.92M) should trail both.
---
## Executive Brief: Hedging Our EUR 6.3M Receivable
To: CFO | From: Niko Bonilla | Date: October 30, 2026

#The exposure
We invoiced Finnish lumber mill EUR 6,300,000, due in 182 days (about April 30, 2027). The euro amount is fixed, however, the dollar amount is not. At roughly 1.118, the receivable is worth about $7.04 million.  For every cent that EURUSD falls we lose $63,000. A 5% decline in the euro costs about $352,000. A 10% decline would mean losing around $704,000 which is a big dent in our budget. As the euro falls we lose out but if it goes up we gain.

#Three ways to hedge
Forward. We sell EUR 6.3M for dollars at a rate fixed today. At the indicative 1.1705, that locks in $7.37 million. Pro: complete certainty. Con: we give up the gain if the euro strengthens.

Money-market hedge. We borrow euros today against the coming payment, convert them at spot, and invest the dollars; the customer's payment repays the loan. It is a do-it-yourself forward built from interest rates, locking in about $7.10 million. Pro: certainty without relying on a bank's forward quote. Con: it uses borrowing capacity and has more moving parts.

We borrow euros today, convert them at spot rate and then invest in dollars. The customer would then pay us back the loan with this forward built from interest rates, and then we can lock in ~$7.10 million. Pro: we have certainty and are not dependent on the banks forward. Con: we are using our debt facility and there are more components involved.

Put option on EUR. We have the option to sell the Euros at a price of 1.118 for a premium of $0.0194 per euro, or $122,220. Pro: a floor under proceeds with upside kept. Con: the premium is spent whether or not we need the protection. Think of it as fire insurance. I am not considering the call option, since it protects a payable, not a receivable.

# What I am assuming
- Spot is 1.1180 (October 29 close); the USD rate is 4.28% (6-month T-bill, Federal Reserve H.15); the EUR rate is 2.62% (3-month Euribor on October 28, a proxy for 6 months). Interest is simple, on 182/360.
- Prices on the forward and options are given in the case.
- No credit risk, transaction costs or taxes are taken into consideration.
- If I end up having more time, I would look at the EUR borrow rate as we will be paying Euribor plus a spread.

# Hypothesis
I expect the quoted forward to deliver about $7.37M and the money-market hedge about $7.10M. This would be a gap of roughly around $272,000. Interest-rate parity, with USD at 4.28% and EUR at 2.62%, would mean or allude to a forward near 1.127, so the 1.1705 quote would be above or around 3.8% above parity. With this, I believe the put's net floor (about 1.098, or $6.92M) would trail both, and would beat the money-market hedge only if the euro rises more than 2.6% above spot.

# How I would know I was wrong
If Stage 4 live forward rate is around 1.127, then this will have been a stale quote so the forward plus money market hedge will be at a tie. Also, if the model shows that the floor of the put is higher than that of the forward, it will lead to the result being wrong.

# Next steps
Streamline Process: Designing the workbook (Stage 2). Creating named ranges/tabs, setting up formulas and performing checks. Having the AI create the workbook (Stage 3) based on the design requirements. Auditing the workbook & fixing any issues. Replacing placeholders (Stage 4) with market data from source. Validating results and providing the decision memo with recommendation (Stage 5).
