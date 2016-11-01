First, in `config/random.yml`, set the range of `account_id` that we want to take samples from (`start` and `finish`).
And also set the sample size that we want to take (`sample_size`).

On the command line, run `rake db:migrate` to create the database file and prepare the tables.

There are 5 important database tables that are created in the database file:

1. `cb_api_responses_account_collages`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It will call a random list of accounts (as many as the specified `sample_size`, and between the specified `start` and `finish`), and then store the `api_response`s.
Since the account can share the collage to either PicCollage, Facebook, or Twitter, so in this table, there will be 3 records for each sample accounts taken (3 `api_response`s per account).
The columns in the table:

- `id`: SQLite database identifier
- `account_id`: the ID of accounts that created the collage
- `api_response`: the response from the API when we make this call request
- `shared_to`: the social networks that each account can share a collage to
- `response_status`: the status of the API response
#
2. `proc_account_collages`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It will record the collages from the accounts taken as samples. It will give us the information of how many unique collages created by each account. The columns in the table:

- `id`: SQLite database identifier
- `account_id`: the ID of accounts that created the collage
- `collage_id`: the ID of each collage created
- `shared_to`: the social network that the collage was shared to
#
3. `cb_api_responses_collage_structures`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It will call the list of collages that were created by the accounts in the sample, and then store the `api_response`s. The columns in the table:

- `id`: SQLite database identifier
- `account_id`: the ID of accounts that created the collage
- `collage_id`: the ID of each collage created
- `api_response`: the response from the API when we make this call request
- `response_status`: the status of the API response
- `shared_to_cb`: identifies if the collage was shared to PicCollage
- `shared_to_fb`: identifies if the collage was shared to Facebook
- `shared_to_tw`: identifies if the collage was shared to Twitter
#
4. `proc_collage_summaries`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It will summarize the collages made by the sample accounts to understand more about the characteristics and elements of collages, so that we could make clusters of collages based on this.
The columns in the table:

- `id`: SQLite database identifier
- `account_id`: the ID of accounts that created the collage
- `collage_id`: collage id in the PicCollage architecture
- `is_echo_collage`: identifies if collage is echo
- `shared_to_cb`: identifies if collage was shared to PicCollage
- `shared_to_fb`: identifies if collage was shared to Facebook
- `shared_to_tw`: identifies if collage was shared to Twitter
- `collage_date_seconds`: timestamp of the collage creation (in seconds)
- `collage_year`: year of collage creation
- `collage_month`: month of collage creation
- `collage_day`: day of collage creation
- `collage_hour`: hour of collage creation
- `collage_minute`: minute of collage creation
- `collage_second`: second of collage creation
- `collage_timezone`: timezone of collage creation
- `collage_day_of_week`: day (as string) of collage creation
- `collage_full_date`: collage creation date
- `device_id`: the id of the device used to create collage
- `purchases`: amount of purchases by the account in each collage creation
- `app_version`: PicCollage version used to create the collage
- `device_os`: the operating system of the device
- `device_os_version`: the version of device operating system
- `device_model`: the model of the device
- `device_lang`: the language used in the device
- `collage_height`: the height of the collage in pixels
- `collage_width`: the width of the collage in pixels
- `has_grid`: identifies if collage used grid
- `collage_scrap_count`: the amount of collage scraps
- `has_background`: identifies if the collage has a background
- `background_source`: the source of the background
- `has_stickers`: identifies if the collage has stickers
- `sticker_count`: amount of stickers in the collage
- `has_text`: identifies if the collage contains text
- `text_count`: amount of text scraps in the collage
- `text`: the text in the collage text scraps
- `text_word_count`: amount of words in the text scraps
- `text_font_name`: the font name used in the text scraps
- `text_font_size`: the font size used in the text scraps
- `text_sentiment`: the sentiment category of the text
- `text_sentiment_score`: the sentiment score of the text
- `has_images`: identifies if the collage has images
- `total_images`: the amount of images in the collage
- `web_image_count`: the amount of images from web in the collage
- `device_image_count`: the amount of images from device in the collage
- `bundled_image_count`: the amount of images from bundle in the collage
- `fb_image_counter`: the amount of images from Facebook in the collage
- `ig_image_counter`: the amount of images from Instagram in the collage
- `yt_image_counter`: the amount of YouTube videos in the collage
- `aviary_image_count`: the amount of Aviary images in the collage
- `collage_overwhelmingness`: the sum of scraps area
- `collage_has_scaling`: identifies if at least one scrap used scaling
- `collage_scaling_count`: the amount of scrap scaling in the collage
- `collage_average_scaling`: the average of scaling in the collage
- `collage_has_rotation`: identifies if at least one scrap used rotation
- `collage_rotation_count`: the amount of scrap rotation in the collage
- `collage_average_rotation`: the average of rotation in the collage
#
5. `proc_account_summaries`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It will summarize the account taken as samples to understand more their collaging behavior, and therefore we can make segmentation or clusters of accounts based on this.
The columns in the table:
- `id`: SQLite database identifier
- `account_id`: PicCollage account ID (hashed)
- `collage_count`: the amount of collages created by account
- `collage_year_mode`: the mode of collages creation year
- `collage_month_mode`: the mode of collages creation month
- `collage_day_mode`: the mode of collages creation day
- `collage_hour_mode`: the mode of collages creation hour
- `collage_first_date`: the timestamp of the account's first collage
- `collage_last_date`: the timestamp of the account's last collage
- `account_active_date_range`: the difference between `collage_last_date` and `collage_first_date`
- `collage_sharing_frequency`: the amount of account's active days divided by the amount of collages
- `has_purchases`: identifies if the account has purchases
- `device_os_mode`: the mode of device's operating system to create collages
- `canvas_size_mode`: the mode of canvas size used
- `scrap_count_sum`: sum of scraps used in collages
- `scrap_count_mean`: mean of scraps used in collages
- `scrap_count_median`: median of scraps used in collages
- `has_background_mean`: mean of background use
- `has_stickers_mean`: mean of sticker use
- `sticker_count_mean`: mean of stickers used in collages
- `has_text_mean`: mean of text scrap use
- `text_count_mean`: mean of text scrap count
- `text_word_count_sum`: sum of words used in collages
- `text_word_count_mean`: mean of words used in collages
- `text_word_count_median`: median of words used in collages
- `text_font_size_mean`: mean of font size used in collages
- `text_sentiment_score_mean`: mean of text sentiment scores
- `text_sentiment_score_min`: minimum of text sentiment scores
- `text_sentiment_score_max`: maximum of text sentiment scores
- `web_image_count_sum`: sum of images from web used in collages
- `web_image_count_mean`: mean of images from web used in collages
- `web_image_count_median`: median of images from web used in collages
- `device_image_count_sum`: sum of images from device used in collages
- `device_image_count_mean`: mean of images from device used in collages
- `device_image_count_median`: median of images from device used in collages
- `bundled_image_count_sum`: sum of images from bundle used in collages
- `bundled_image_count_mean`: mean of images from bundle used in collages
- `bundled_image_count_median`: median of images from bundle used in collages
- `fb_image_counter_sum`: sum of images from Facebook used in collages
- `fb_image_counter_mean`: mean of images from Facebook used in collages
- `fb_image_counter_median`: median of images from Facebook used in collages
- `ig_image_counter_sum`: sum of images from Instagram used in collages
- `ig_image_counter_mean`: mean of images from Instagram used in collages
- `ig_image_counter_median`: median of images from Instagram used in collages
- `yt_image_counter_sum`: sum of YouTube videos used in collages
- `yt_image_counter_mean`: mean of YouTube videos used in collages
- `yt_image_counter_median`: median of YouTube videos used in collages
- `aviary_image_count_sum`: sum of Aviary images used in collages
- `aviary_image_count_mean`: mean of Aviary images used in collages
- `aviary_image_count_median`: median of Aviary images used in collages
- `has_images_mean`: mean of image use
- `total_images_sum`: sum of all images used in collages
- `total_images_mean`: mean of all images used in collages
- `total_images_median`: median of all images used in collages
- `collage_overwhelmingness_mean`: mean of scraps area
- `collage_average_scaling_mean`: mean of scrap scaling
- `collage_average_rotation_mean`: mean of scrap rotation
- `has_grid_mean`: mean of grid use
