# 10paisa

<p align="center">
  <img width="300" height="300" src="assets/logos/logo.png?raw=true">
</p>


A Smart Investment App made for Softwarica College of IT & E-Commerce, Coventry University

## Overview

The Smart Investment Application is a state-of-the-art application that gives users the knowledge and insights they need to maximize their investment strategy. Utilizing technology, data analytics, and intelligent systems, this ground-breaking program offers users individualized investment suggestions, portfolio management, and real-time market analysis.

## Features

- User registration and portfolio management: user registration, login, etc.
 
- Investment dashboard: a dashboard displaying an overview of the user's investment portfolios. End-of-day updates on investment opportunities, gains, and losses
 
- Diverse asset classes: The app supports multiple asset classes like bonds, mutual funds, stocks, SIPs, IPOs, FPOs, etc. The app also provides detailed information and research on each investment   asset class or opportunity.
 
- Portfolio tracking: ability to add, edit, and remove investments or portfolios. Portfolio performance charts and graphs.
 
- Portfolio rebalancing: portfolio rebalancing recommendations Ability to rebalance portfolios based on user criteria.
 
- Research and Analysis: Market news and updates, financial asset comparison, and research
  Investment recommendations are based on user preferences and goals.
 
- Goal Planning: Set financial goals (e.g retirement, children's education, buying a house).
  Track progress towards achieving those goals.

- Portfolio Comparison: comparing portfolios in terms of their dividend yield, yearly returns, capital appreciation, and liquidity.
 
- Transaction History: View the transaction history for all investments.
 
- Financial News and Insights: Up-to-date financial news and articles; data aggregation from third-party related news sites
 
- Personalized Recommendations: Simple algorithm-driven investment recommendations based on the user's financial criteria and goals
 
- Demo buy sell: The app facilitates easy buying and selling of available asset classes and listed securities for learning purposes.
 
- Stock search and sorting: The app facilitates users looking up stocks and investment opportunities.

## Screenshots
<img src="figma/grid/Screenshots/1.jpg?raw=true" width="400"/> <img src="figma/grid/Screenshots/2.jpg?raw=true" width="400"/>
<img src="figma/grid/Screenshots/3.jpg?raw=true" width="400"/> <img src="figma/grid/Screenshots/4.jpg?raw=true" width="400"/>
<img src="figma/grid/Screenshots/5.jpg?raw=true" width="400"/>


## Prerequisites

Before you start, make sure you have the following installed:
- Java: The mobile app requires JDK 20. Install JDK 20 from here [Java JDK link](https://www.oracle.com/java/technologies/downloads/).
- Gradle: The mobile app is developed using gradle 8.3. Build using gradle 8.3 in your system. [Gradle releases](https://gradle.org/releases/).
- Flutter: The mobile app is developed using Flutter. Install Flutter by following the official [installation guide](https://flutter.dev/docs/get-started/install).
- Node.js: The backend server is built with Node.js. Install Node.js from the [official website](https://nodejs.org/).
- Android Studio or VS Code : To run the app on an Android emulator or device, you'll need Android Studio or VS Code with the Flutter plugin installed [official website](https://code.visualstudio.com/download).
- Database: You'll need a MongoDB database system or MongoDB Atlas, to store user and financial data. Make sure you have 'paisa' database with 'users' collection [official website](https://www.mongodb.com/try/download/community).

## TODO
- Charts, Notification Listener, wacc, loss gains and other financial calculations. 
- Complete asset View, portfolio view.
- Recommendation system.
- Fetch live data (working on it).

## What Works?
- Login Screen (connected to MongoDB)
- Signup Screen & email verification (uses [Google Mail Service](mail.google.com) service) (connected to MongoDB)
- OTP Screen (EMail OTP, uses [Google Mail Service](mail.google.com) service)
- Password reset, user data update.
- Live stock prices.
- live metals prices.
- Live Nepse Index (web socket)
- live commodities prices (vegetables for now).
- User authorization system works.
- Proper navigation and routing.
- Account deletion.
- live financial news.
- Web socket for live notifications.
- Top gainers, loosers, transaction,volume and turnover.
- AssetView, indetail View, asset related notifications.
- Portfolio, create portfolio, edit portfolio, delete portfolio, add asset to portfolio, edit and delete asset from portfolio.
- Watchlist, create watchlist, edit watchlist, delete watchlist, add asset to watchlist, edit and delete asset from watchlist.
- Wacc calculation, portfolio adjustment, asset news, asset advance candlestick chart (usages third party service).
- Portfolio detailed view, comparision and portfolio recommendation.
- Recommendation system (very basic).

- ## Technology Used
-  Web Socket
-  JSON & JSON web token-  React JS
-  Mongo DB
-  Testing
-  Web scarping
-  Cloud deployment

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/ST60002CEM/batch31a-surajrimal07

