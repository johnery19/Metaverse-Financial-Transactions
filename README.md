# Metaverse-Financial-Transactions

![](Metaverse.jpg)

# Introduction
This project aims to outline the process of identifying potentially fraudulent transactions by comparing individual transaction amounts to the average transaction amount of each sending address. Transactions that exceed the average by more than two standard deviations will be flagged as potentially fraudulent.

**_Disclaimer_** : All datasets and reports do not represent any company, institution or country, but just a dummy dataset to demonstrate capabilities in SQL.

## Problem Statement
- Detecting and mitigating financial impact.
- Identifying patterns and anomalies in transaction data.
- Focusing on transaction types, monthly trends, and high-value transactions.
- Providing comprehensive understanding of fraudulent behaviors.

## Dataset Overview
The dataset provided contains transactional data with the following columns:

1. **transaction_id**: Unique identifier for each transaction.
2. **timestamp**: The date and time when the transaction occurred.
3. **sending_address**: The address from which the transaction originated.
4. **receiving_address**: The address to which the transaction was sent.
5. **amount**: The amount of currency transferred in the transaction.
6. **transaction_type**: The type of transaction (e.g., transfer, payment).

## Analysis Objectives
- Calculate the average transaction amount for each sending address.
- Calculate the standard deviation of transaction amounts for each sending address.
- Identify transactions where the amount exceeds the average by more than two standard deviations.
- Highlight potentially fraudulent transactions.
- Provide insights into patterns of fraudulent activity.

## Skills Demonstrated
I conducted comprehensive data analysis using SQL to extract, manipulate, and analyze data, applying statistical techniques for averages, confidence intervals, and distribution metrics, while ensuring data quality through cleaning operations. Leveraging domain knowledge in Metaverse Financial Transactions

## Insight 

- Data analysis reveals patterns in transaction types, monthly trends, and specific sending addresses.
- Highest number of potentially fraudulent transactions occur in the 'Purchase' category, followed by 'Sale' and 'Transfer'.
- Most common potential fraud counts per sending address are 2, 3, 4, and 5.
- Fraudulent transactions are relatively evenly distributed throughout the year but peak in **August** and **May**.
- The highest fraudulent amount recorded is **$7980.09**, indicating potential large-scale fraud.
- High-risk transaction types include **purchases**, **sales**, and **transfers**.
- Repeated use of sending addresses suggests fraudsters might be reusing addresses for multiple fraudulent activities.
- Certain months, particularly **August** and **May**, show higher incidences of fraud.
- Significant high-value fraud underscores the importance of immediate action when anomalies are detected.

  **_By focusing on these insights, organizations can improve their fraud detection mechanisms, prioritize monitoring during peak fraud months, and better understand the transaction types most susceptible to fraud._**
