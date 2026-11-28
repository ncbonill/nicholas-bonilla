# **Independent EUR Receivable Hedge Analysis — Scenario 5: Sawmill-Machinery**

## **1. Executive summary**

Based exclusively on the two attached documents, I independently recalculated all four EUR receivable hedging strategies using the updated Stage 4 market inputs dated November 20, 2026.

The receivable is **€6,300,000**, due in 182 days. The company is a U.S. sawmill-machinery manufacturer receiving euros from a Finnish lumber mill.

Best modeled strategy: Forward hedge

**My recommendation is to use the forward hedge, subject to obtaining and verifying an actual bank forward quotation.**

The forward produces $7,374,150, compared with $6,975,938.80 from the money-market hedge. It also outperforms the unhedged and put-option strategies in all eleven specified sensitivity scenarios.

However, there is a significant problem: the forward rate supplied in the documents is not a verified live bank quote and differs materially from the rate implied by the selected interest rates.

This means the forward is the best result in the mathematical comparison, but its commercial attractiveness cannot be confirmed until the quotation is independently verified.

The calculations below use:

- The original technical specification for the hedge formulas and conventions.
- The November 20 market-data memo for the updated inputs.

I have not substituted outside market data or silently changed any assumptions.

## **2. Inputs used in the calculations**

The November 20 market-data memo supplies the updated values. These replace the original placeholder spot and interest-rate assumptions in the technical specification.

| Input     | Value      | Description              |
| --------- | ---------- | ------------------------ |
| FC_AMT    | €6,300,000 | EUR receivable           |
| S0_in     | 1.0990     | USD/EUR spot             |
| F0_in     | 1.1705     | Scenario forward rate    |
| R_USD     | 4.51%      | USD annual interest rate |
| R_FC      | 2.995%     | EUR annual interest rate |
| K_PUT     | 1.0990     | EUR put strike           |
| K_CALL    | 1.0990     | EUR call strike          |
| PREM_PUT  | 0.0194     | Put premium per EUR      |
| PREM_CALL | 0.0296     | Call premium per EUR     |
| T_DAYS    | 182        | Settlement period        |

Both interest rates use ACT/360.

**Important:** The spot rate is an ECB reference rate. The interest rates are government-bond yield proxies, not matched-term deposit or borrowing rates. The forward and option premiums are scenario assumptions rather than verified live quotations.&#x20;

2026-11-20-sawmill-machinery-market-data-memo (1).md



## **3. Independent calculations**

### **A. No-hedge strategy**

The company keeps its EUR receivable and converts the entire amount into USD at the future spot rate.

Formula:

\\[ USD\_{NO\\\_HEDGE}=FC\\\_AMT\times S_T \\]

At the current spot rate:

\\[ 6,300,000\times1.0990 \\]

\\[ \boxed{\\$6,923,700} \\]

**Finding:** This strategy has unlimited upside if the euro appreciates, but it also exposes the company to losses if the euro depreciates.

There is no guaranteed minimum USD proceeds amount.

### **B. Forward hedge**

The company agrees to exchange the €6.3 million receivable at the specified forward rate of 1.1705 USD/EUR.

Formula:

\\[ USD\_{FWD}=FC\\\_AMT\times F0\\\_in \\]

Substitution:

\\[ 6,300,000\times1.1705 \\]

\\[ \boxed{\\$7,374,150} \\]

**Finding:** The forward guarantees the modeled USD proceeds regardless of the future EUR/USD exchange rate.

This eliminates the exchange-rate uncertainty associated with the receivable.

Its disadvantage is that the company gives up the opportunity to benefit from a stronger euro above the contracted rate.

### **C. Money-market hedge**

The money-market hedge involves three steps.

**Step 1: Borrow euros today.**

The company borrows an amount that, with accrued EUR interest, will equal the €6.3 million receivable at settlement.

\\[ DF\_{FC}=1+R\_{FC}\times\frac{T}{360} \\]

\\[ =1+0.02995\times\frac{182}{360} \\]

\\[ =1.015141389 \\]

Calculate the EUR borrowing:

\\[ Borrowed\\\_EUR= \frac{6,300,000}{1.015141389} \\]

\\[ \boxed{€6,206,032.06} \\]

**Step 2: Convert borrowed euros into USD today.**

\\[ USD\_{Today}=Borrowed\\\_EUR\times S0\\\_in \\]

\\[ =6,206,032.06\times1.0990 \\]

\\[ \boxed{\\$6,820,429.23} \\]

**Step 3: Invest the USD until settlement.**

First, calculate the USD accumulation factor:

\\[ DF\_{USD}=1+R\_{USD}\times\frac{T}{360} \\]

\\[ =1+0.0451\times\frac{182}{360} \\]

\\[ =1.022800556 \\]

Then calculate the investment proceeds:

\\[ USD\_{MM}=USD\_{Today}\times DF\_{USD} \\]

\\[ =6,820,429.23\times1.022800556 \\]

\\[ \boxed{\\$6,975,938.80} \\]

At settlement, the company uses its €6.3 million receivable to repay the EUR borrowing and interest.

**Finding:** The money-market hedge removes the exchange-rate exposure by converting and investing the borrowed euros today.

However, under the supplied assumptions, it generates $398,211.20 less than the forward hedge.

### **D. EUR put-option hedge**

The EUR put gives the company the right to sell euros at the strike price of 1.0990 USD/EUR.

The company pays the option premium upfront.

Formula:

\\[ USD\_{PUT}= FC\\\_AMT\times\max(S_T,K\_{PUT}) -FC\\\_AMT\times PREM\_{PUT} \\]

First, calculate the premium:

\\[ 6,300,000\times0.0194 \\]

\\[ =\\$122,220 \\]

Next, calculate the minimum proceeds:

\\[ PUT\\\_FLOOR= 6,300,000\times1.0990-122,220 \\]

\\[ \boxed{\\$6,801,480} \\]

**Finding:** The put provides downside protection while allowing the company to benefit from euro appreciation above the strike, less the option premium.

The trade-off is the $122,220 upfront premium.

Unlike the forward, the put does not lock in a single final exchange rate.

The premium is deducted at settlement in accordance with the professor's specified calculation convention. No future-value adjustment has been applied.&#x20;

spec(1).md



## **4. Covered interest rate parity calculation**

This is one of the most important findings in the analysis.

The technical specification requires the money-market and forward hedges to produce approximately equal proceeds under covered interest rate parity.

The implied forward rate is:

\\[ F\_{CIP}= S_0\times \frac{1+R\_{USD}(182/360)} {1+R\_{EUR}(182/360)} \\]

Substitution:

\\[ F\_{CIP}= 1.0990\times \frac{1.022800556}{1.015141389} \\]

\\[ \boxed{F\_{CIP}=1.107291874} \\]

Compare the implied forward with the scenario forward:

| Measure                | Result   |
| ---------------------- | -------- |
| Scenario forward       | 1.170500 |
| CIP-implied forward    | 1.107292 |
| Difference             | 0.063208 |
| Difference as % of CIP | 5.71%    |

The difference in USD proceeds is:

\\[ 7,374,150-6,975,938.80 \\]

\\[ \boxed{\\$398,211.20} \\]

As a percentage of forward proceeds:

\\[ \frac{398,211.20}{7,374,150}\times100 \\]

\\[ \boxed{5.40\\%} \\]

Parity check: FAIL

The forward and money-market proceeds do not agree within the specification's required 0.05% tolerance.

This is a material discrepancy, not a rounding difference.

The Stage 4 memo also identifies this discrepancy and explicitly says the inputs should not be changed simply to force a passing result.&#x20;

2026-11-20-sawmill-machinery-market-data-memo (1).md



## **5. Eleven-scenario sensitivity analysis**

The technical specification requires eleven ending exchange-rate scenarios, ranging from -5% to +5% relative to the updated spot rate of 1.0990.

The scenario formula is:

\\[ S_T=1.0990\times(1+\text{percentage shift}) \\]

I independently calculated all four strategies at every ending exchange rate.

All proceeds in USD. Calculations use unrounded intermediate values; displayed results are rounded to cents.

| Change | Ending spot | No hedge   | Forward    | Money market | EUR put    |
| ------ | ----------- | ---------- | ---------- | ------------ | ---------- |
| -5%    | 1.04405     | $6,577,515 | $7,374,150 | $6,975,939   | $6,801,480 |
| -4%    | 1.05504     | $6,646,752 | $7,374,150 | $6,975,939   | $6,801,480 |
| -3%    | 1.06603     | $6,715,989 | $7,374,150 | $6,975,939   | $6,801,480 |
| -2%    | 1.07702     | $6,785,226 | $7,374,150 | $6,975,939   | $6,801,480 |
| -1%    | 1.08801     | $6,854,463 | $7,374,150 | $6,975,939   | $6,801,480 |
| 0%     | 1.09900     | $6,923,700 | $7,374,150 | $6,975,939   | $6,801,480 |
| +1%    | 1.10999     | $6,992,937 | $7,374,150 | $6,975,939   | $6,870,717 |
| +2%    | 1.12098     | $7,062,174 | $7,374,150 | $6,975,939   | $6,939,954 |
| +3%    | 1.13197     | $7,131,411 | $7,374,150 | $6,975,939   | $7,009,191 |
| +4%    | 1.14296     | $7,200,648 | $7,374,150 | $6,975,939   | $7,078,428 |
| +5%    | 1.15395     | $7,269,885 | $7,374,150 | $6,975,939   | $7,147,665 |

### **Sensitivity analysis findings**

**1. Forward hedge**

The forward produces $7,374,150 in every scenario. It is the highest-returning strategy across all eleven scenarios.

**2. No hedge**

Unhedged proceeds increase as the euro appreciates and decrease as it depreciates.

At -5%, proceeds are $6,577,515. At +5%, they increase to $7,269,885.

Even at +5%, the unhedged strategy does not outperform the supplied forward rate.

**3. Money-market hedge**

Money-market proceeds remain constant at $6,975,938.80 regardless of the ending spot rate.

This is because the currency conversion and USD investment take place at inception.

**4. EUR put**

The put produces its minimum net proceeds of $6,801,480 when the ending spot is at or below the strike.

Above the strike, the company benefits from the higher conversion rate, minus the option premium.

At +5%, proceeds reach $7,147,665.

### **Which strategy wins?**

Forward wins all 11 scenarios

| Ending spot scenarios | Best strategy |
| --------------------- | ------------- |
| -5% through 0%        | Forward       |
| +1% through +5%       | Forward       |

There is an important difference between the original specification and the updated market-data memo.

The original specification says the forward should win from -5% through 0%, with no hedge winning from +1% through +5%. That expected result was based on the original forward and spot assumptions.

The updated market memo retains the forward at 1.1705 while reducing spot to 1.0990. Consequently, the forward is above even the highest sensitivity spot of 1.15395.

Therefore, the original expected winner pattern no longer applies.

The table above uses the updated inputs, not the original placeholder scenario.

## **6. Overall strategy comparison**

At the current spot rate of 1.0990, the four strategies produce:

# **$7,374,150**

**Forward hedge**

Highest modeled proceeds

**Money-market hedge**

**$6,975,938.80**

**No hedge**

**$6,923,700.00**

**EUR put**

**$6,801,480.00**

Base-case proceeds comparison, using S_T = S0_in.

| Comparison                | Dollar difference |
| ------------------------- | ----------------- |
| Forward vs. money market  | +$398,211.20      |
| Forward vs. no hedge      | +$450,450.00      |
| Forward vs. put           | +$572,670.00      |
| Money market vs. no hedge | +$52,238.80       |
| Money market vs. put      | +$174,458.80      |

The forward hedge provides the greatest modeled certainty and proceeds under the supplied scenario assumptions.

The put is less attractive in the eleven specified scenarios because its premium reduces proceeds and its strike is equal to current spot.

The money-market hedge provides a fixed USD outcome, but the selected rates make it less favorable than the supplied forward.

## **7. Assumptions, ambiguities, and limitations**

These are important because the calculations are only as reliable as the information and assumptions supporting them.

### **A. Forward rate is not independently verified**

The 1.1705 forward rate comes from the original scenario specification.

The market-data memo explicitly says that no bank quote was obtained.

This is the most important limitation because the forward hedge is the winning strategy largely because its quoted rate is substantially higher than the CIP-implied rate.

A same-date, same-settlement-date bank quotation is needed before recommending execution.

### **B. Interest rates are proxies**

The USD rate is based on the U.S. one-year Treasury yield of 4.51%.

The EUR rate is based on Germany's one-year government bond yield of 2.995%.

Neither is a matched 182-day borrowing or deposit rate.

Consequently, the money-market hedge calculation is a theoretical comparison based on government-yield proxies rather than actual bank funding costs.

### **C. Option premiums are assumptions**

The put premium of 0.0194 USD/EUR and call premium of 0.0296 USD/EUR were retained from the original scenario.

They are not verified market quotations.

Actual option pricing could materially change the relative attractiveness of the option strategy.

### **D. Transaction costs are excluded**

The technical specification excludes:

- Bank fees.
- Bid-ask spreads.
- Transaction costs.
- Taxes.

These costs could change the actual net proceeds of each strategy.

### **E. Option premium timing**

The specification requires the entire put premium to be deducted from settlement proceeds without adjusting for its time value.

This is a prescribed modeling convention, not necessarily the complete economic cost of paying the premium upfront.

### **F. Scenario analysis does not assign probabilities**

The eleven scenarios represent deterministic exchange-rate changes.

They do not estimate the probability of any particular future exchange rate.

The model also does not incorporate implied volatility or the likelihood of different outcomes.

### **G. Forward and put are not directly equivalent**

The forward locks in the exchange rate and eliminates upside from euro appreciation.

The put provides a minimum conversion rate while preserving upside above the strike, less the premium.

Therefore, the decision also depends on Treasury's preference for certainty versus flexibility.

### **H. Original specification and updated market memo contain different inputs**

The original specification used:

- Spot: 1.1609.
- USD interest rate: 4.28%.
- EUR interest rate: 2.62%.

The November 20 memo uses:

- Spot: 1.0990.
- USD interest rate: 4.51%.
- EUR interest rate: 2.995%.

The updated values were used throughout this analysis. The original base-case reference values should not be treated as validation results for the updated model.

The call option is also not included as a fourth receivable strategy because the specification explicitly identifies it as relevant to a future EUR payable, not this receivable.



spec(1).md

2026-11-20-sawmill-machinery-market-data-memo (1).md



## **8. Final recommendation to Treasury**

I recommend the **forward hedge as the preferred strategy under the supplied scenario inputs**, but I would make execution conditional on verifying the forward quotation.

There are three reasons:

1\. **Highest modeled proceeds:** The forward locks in $7,374,150, exceeding the other three strategies in every one of the eleven scenarios.

2\. **Eliminates exchange-rate uncertainty:** The company knows exactly how many dollars it will receive, protecting its USD cash flow and reducing exposure to euro depreciation.

3\. **Outperforms the alternatives:** Even at the highest sensitivity spot rate of 1.15395, unhedged proceeds are $7,269,885, still $104,265 below the forward proceeds.

However, I would not advise the CFO to execute the forward solely on the basis of the 1.1705 scenario rate.

The 5.71% difference between the supplied forward rate and the CIP-implied rate is too significant to ignore. Treasury should first obtain a bank quotation for the exact 182-day settlement date and update the comparison using matched-term funding rates.

If the verified forward quote remains attractive, the forward is my preferred choice. If it does not, Treasury should reconsider the money-market hedge and EUR put using actual market quotations.

## **9. Conclusion**

The independent calculations demonstrate that the forward hedge is the strongest strategy under the supplied numerical assumptions. It offers fixed USD proceeds of $7,374,150 and outperforms the unhedged, money-market, and put-option alternatives throughout the specified sensitivity range.

The money-market hedge also removes exchange-rate risk, but its proceeds are lower because of the selected interest-rate assumptions. The EUR put offers downside protection and upside participation, but its premium reduces net proceeds. Remaining unhedged offers the greatest exposure to favorable exchange-rate movements, but also exposes the company to unfavorable movements.

The most important finding is the discrepancy between the supplied forward rate and the CIP-implied forward rate. This means the numerical winner should not automatically be treated as the best executable transaction.

**Ultimately, I recommend the forward hedge subject to independent bank-quote verification.** This approach prioritizes predictable USD cash flows while recognizing that the market-data limitations must be resolved before an actual hedging decision is made.

## **10. Independent calculation audit**

**Results of my independent checks**

Input calculations

Recalculated

Forward proceeds

Reconciled

Three-step money-market hedge

Reconciled

Put premium and floor

Reconciled

Eleven sensitivity scenarios

Recalculated

Strategy rankings

Recalculated

Covered interest parity

Fail

Live forward quote verification

Outstanding

These checks establish that the calculations are internally consistent with the formulas and inputs in the two documents. They do not establish that the market quotations are executable or that the workbook itself has passed every Excel validation test.

**Source restriction:** This analysis uses only the two supplied documents: the Technical Specification and the November 20, 2026 Stage 4 Market Data Memo. No external market information was introduced.
