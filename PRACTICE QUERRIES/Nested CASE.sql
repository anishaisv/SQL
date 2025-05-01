SELECT 
    User_ID,
    Account_Name,
    User_Name,
    Followers,
    Posts,
    CASE
        -- Step 1: Check if the user is an Influencer (has more than 300 followers)
        WHEN Followers > 300 THEN 
            -- Step 2: Inside the Influencer condition, check if they are a Special Influencer
            CASE
                WHEN Followers >= 400 THEN 'Special Influencer'  -- Updated condition for Special Influencer
                ELSE 'Influencer'
            END
        -- Step 3: If the user is not an Influencer, check if they are an Active User based on posts
        WHEN Posts > 100 THEN 'Active User'
        -- Step 4: Otherwise, categorise them as a Regular User
        ELSE 'Regular User'
    END 
	AS User_Category

FROM user_data;
