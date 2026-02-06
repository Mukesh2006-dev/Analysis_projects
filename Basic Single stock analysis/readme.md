📈 Simple Stock Analysis using Python
Overview

This project is a basic stock market analysis done during my free time to understand how risk and return behave in real market data.
The goal was learning, not prediction or trading signals.

I focused on understanding:

How returns are calculated

How risk shows up over time

How basic financial metrics are interpreted

Why this project

Stock market concepts like returns, volatility, drawdown, and Sharpe ratio are widely used in finance and data analysis, but they are often treated as formulas without understanding.

This project helped me:

Connect formulas to real data

Understand why metrics behave the way they do

Practice practical data analysis instead of theory only

Why Python (and not any other language)

Python was chosen intentionally:

✅ Pandas makes time-series financial data easy to handle

✅ NumPy supports fast and reliable numerical computations

✅ Matplotlib allows simple and clear visualizations

✅ Python is widely used in data science, finance, and analytics

✅ Easy to experiment and iterate during free time

Using Python allowed me to focus on concepts and analysis, not syntax overhead.

Analysis Performed
1. Daily Returns

Calculated daily percentage change to measure day-to-day performance.

Purpose:

Understand short-term fluctuations

Base metric for risk and return calculations

2. Cumulative Returns

Computed compounded returns over time to represent portfolio growth.

Purpose:

Show how wealth evolves over time

Used for drawdown analysis

3. Rolling Volatility (Risk)

Calculated rolling standard deviation of daily returns.

Purpose:

Identify high-risk and low-risk periods

Observe how risk changes over time

4. Drawdown & Maximum Drawdown

Measured the fall from historical peaks to understand downside risk.

Purpose:

Quantify worst loss scenarios

Capture investor pain, not just volatility

5. Sharpe Ratio

Calculated risk-adjusted return using mean return and volatility.

Purpose:

Evaluate whether returns justify the risk taken

6. Moving Averages (Trend Identification)

Used short-term and long-term moving averages to identify gain/loss regimes.

Purpose:

Detect sustained uptrends and downtrends

Understand time-based performance behavior

Visualizations

Daily Returns vs Cumulative Returns

Rolling Volatility over time

Risk vs Return scatter plot

These plots help visually connect risk and return behavior instead of relying only on numbers.

Tools & Libraries

Python

Pandas

NumPy

Matplotlib

Limitations

This is not a trading strategy

No prediction or machine learning

Single asset analysis

Risk-free rate assumed as zero for simplicity

The project is intentionally simple and focused on fundamentals.

What I learned

Difference between daily, cumulative, and annualized returns

Why drawdown matters more than volatility alone

How Sharpe ratio complements drawdown and volatility

Importance of time-dependent analysis in finance
