

SET IDENTITY_INSERT user_data ON;
 
INSERT INTO user_data (User_ID, Account_Name, User_Name, Age, Gender, Date_Joined, Posts, Likes, Followers, Following)

VALUES

(1, 'starlight_dancer', 'Emma Johnson', 28, 'Female', '2020-05-15', 120, 450, 200, 150),

(2, 'zen_master', 'Chris Roberts', 30, 'Male', '2019-12-20', 80, 300, 150, 180),

(3, 'neon_ninja', 'Jordan Lee', 25, 'Other', '2021-02-10', 95, 600, 250, 220),

(4, 'sky_wanderer', 'Alex Smith', 32, 'Male', '2018-11-04', 200, 900, 350, 300),

(5, 'sunset_lover', 'Taylor Brown', 27, 'Female', '2017-09-01', 150, 800, 400, 380);
 
SET IDENTITY_INSERT user_data OFF;

 