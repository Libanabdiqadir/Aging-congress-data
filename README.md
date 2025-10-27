# Aging-congress-data
U.S. Congress Members SQL Analysis
This project analyzes data from the U.S. Congress dataset, which includes infromation about members, their states, parties, and years ofr services.

The goal of this analysis is to explore patterns in political affiliation, longevity, and historical representation using SQL queries and PostgreSQL.

# Tools Used
1. PostgreSQL

2. PgAdmin 4

## 💻 Project Setup

To set up the database and run the analysis, follow these steps:

1.  *Data Source:* Ensure the *congress_data.csv* file is in the project directory.
2.  *Load Schema & Data:* Execute the entire setup_tables.sql file against your database. This file uses the COPY command to import data directly from congress_data.csv into the congress table.
3.  *Run Queries:* Execute the commands in the queries.sql file to see the analysis results.


# 📊 Questions Explored
🧩 1. Basic Understanding


A. How many total records and unique members are in the dataset?

B. What is the earliest and latest Congress session?

C. How many members served in the House vs. Senate?

D. How many states are represented?

E. How many unique parties are there?


🧓 2. Age & Generational Insights


A. Average age by congress.

B. Which congress was younges and oldest

C. Average age difference between House and Senate

D. Dominant generation in each congress

E. How many generation changed over time


🗺 3. State-Level Analysis


A. Top 5 states with most members

B. States with oldest average members

C. States with youngest average members

D. States age increase over time 


⚖️ 4. Party and Chamber Comparisons


A. Average age per political party

B. Oldest party members on average

C. Senate vs House age comparison

D. Average age trend by party over time

E. Generation distribution by party


⏳ 5. Career & Tenure Analysis


A. Top 10 longest-serving members
B. Average number of sessions per member
C. Longest-serving generation
D. Average starting age of members


🚀 6. Time Trends


A. Average age per decade

B. When Boomers overtook Silent generation

C. Age distribution by Congress

D. Median or central trend (approximate)

E. House vs Senate age gap trend


🧠 7. Advanced Storytelling


A. Youngest member ever

B. Oldest member ever

C. Most common generation overall

D. Decade with biggest average age jump

E. Average career length (first to last Congress)
