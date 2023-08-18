# Thiran Challenge-[API & SQFLite] GithubTrending-App

<img src=https://github.com/thedemonKingx1337/Thiran-Challenge-2-Github-API/assets/43701328/1922ef82-2e25-47cc-9387-291a952ea4cc width="300" height="650"/>

## Getting Started

### Problem Statment : 
The task is to implement a small app that will list the most starred 
Github repos that were created in the last 90 days. You'll be fetching the sorted JSON data 
directly from the Github API.
Features:
As a User I should be able to list the most starred GitHub repos that were created in the last 
30 days. As a User I should see the results as a list. One repository per row.
As a User I should be able to see for each repo/row the following details:
• Repository name
• Repository description
• Numbers of stars for the repo.
• Username and avatar of the owner.
To get the most starred GitHub repos created in the last 30 days, you'll need to call the 
following endpoint:
https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc 
The JSON data from GitHub will be paginated.
Technology to use: Flutter & SQFlite
