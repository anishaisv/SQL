select * from user_data

select Account_Name,Followers from user_data order by Followers desc

select Account_Name from user_data where Gender='Female' and Date_Joined < '2020-01-01';

select Account_Name,Posts,Likes from user_data where Posts>100 and Likes<500

select count(*) as User_Count from user_data where Date_Joined>'2020-01-01'

select Gender,sum(Likes) as Total_Likes from user_data group by Gender

select sum(Posts) as Total_Posts from user_data

SELECT AVG(Likes) AS Avg_Likes FROM user_data WHERE Followers > 200 GROUP BY Followers;

select top 3 Account_Name,Likes from user_data order by Likes Desc

select @@SERVERNAME