# e-Commerce-Reviews-Text-Mining
Project that uses a e-commerce website reviews to understand consumer behavior, predict whether a consumer will buy a product or not

## Project Statement
This is a dataset from an e-commerce website includes 23486 rows and 10 feature variables. Each row corresponds to a customer review, and includes the variables:
Clothing ID: Integer Categorical variable that refers to the specific piece being reviewed.

Age: Positive Integer variable of the reviewers age.

Title: String variable for the title of the review.

Review Text: String variable for the review body.

Rating: Positive Ordinal Integer variable for the product score granted by the customer from 1 Worst, to 5 Best.

Recommended IND: Binary variable stating where the customer recommends the product where 1 is recommended, 0 is not recommended.

Positive Feedback Count: Positive Integer documenting the number of other customers who found this review positive.

Division Name: Categorical name of the product high level division.

Department Name: Categorical name of the product department name.

Class Name: Categorical name of the product class name

Analyse the data, use EDA and data analytics, and build various models to provide product recommendations.

## Project Background

E-commerce, also known as e-Business or electronic business is, to put it plainly, the purchase & sale of goods over the internet. It is a viable alternative to a traditional brick-and-mortal store. The choices available, ease of transaction, increased use of online payments, rising smartphones penetration, launch of cheap 4G connections, higher spending power of the country as a whole and a youth demographic that is willing to experiment, all have contributed to a growth in the e-commerce industry in India. Ecommerce is also increasingly attracting customers from Tier 2 and 3 cities, where people have limited access to brands but have high aspirations. In fact, as per the Government of India, the e-commerce industry is expected to reach USD 64 Million by the end of 2020. As per the 2018 data collated, electronics has the highest share of e-commerce sales at 48%.

However, Apparels are the next biggest sector at 29% and it is a fast growing segment. By 2025, nonelectronics categories, led by Apparels, are expected to take 80% of share in online retail in India. A 5 year projection starting from 2018 shows that Indian e-commerce industry is expected to grow at 36%. An analysis of the consumer reviews helps understand the consumer behavior, their likes & dislikes and get a general sense of what can be done to improve experience on the website, therefore, improve sales, which in turn contributes to the market share of e-commerce websites.

## Project Objectives

1. One of the main objectives of this project is to understand the dataset and provide recommendations on which products to stock & promote. This will help the e-commerce retailer to organize their warehouses better.
2. Grouping the products to give customers better choices of similar clothing items to the ones they were perusing. This gives the customer freedom of choice, makes them spend more time on the e-commerce website/ app and improves the chances of sales.
3. Analyzing the data to recommend products that complement the items of clothing that are being reviewed. This provides more value to the customer and potentially leads to more sales for the e-commerce website.
4. Provide recommendations on marketing strategies, discounts or buy-one-get-one-free offers to clear existing stocks of slow moving items, incentivize buyers to purchase more and improve e-commerce retailer’s market standing.
5. Analyse reviews to bring pressing issues to the manufacturers to improve clothing quality sold on the website.


## Assumptions about Dataset

The dataset provided, though exhaustive, is not complete. Before I start with my analysis, I prefer to begin with the following assumptions:

1. All the items have been available for sale on the site for more or less, the same amount of time. It is not fair to compare products that are newly launched and products that have been available for a considerable amount of time as this will not provide a fighting chance for the new products.

2. The prices of a class of products is similar. For example, all jeans are priced competitively. We cannot compare a Jeans that is sold at Rs. 10,000 to Jeans that is sold at Rs. 1,500. It is better to compare products similarly priced as it gives best value for the customer at that particular price range.

3. Brand Name plays a big role in persuading a potential customer to make the sale. Research shows that if there are 2 products with similar prices, ratings and review sentiments, the brand swings the vote in favor of one item vs the other. Since the brand name isn’t available, I will assume that all the products available belong to well-known retailers.


## Exploratory Data Analysis Conclusions

1. After cleaning up the data, we are working with 22,629 rows and 12 columns.
2. The most commonly used words in the review texts are dress, love, fit, size & look, all of which have positive connotations.
3. The most commonly used words in review title are love, dress, great, cute & top, again have positive connotations.
4. The clothes that are most reviewed are Dresses & Knits, which can imply that they are the items of clothing that are purchased overall.
5. Reviews are left by a wide age group of women, whose age mainly range between 20 to 70 years old. However, maximum number of reviews are left by 35 to 44 year old women. Hence, we can confidently assume that they are the demographic with the most buying power.
6. 77% of the reviews are positive and 8 of 10 women will recommend an item of clothing to a friend. This implies that the selection & quality is overall good and clients are satisfied.
7. Not all clothing items are widely purchased. Items like Trendy clothes and Intimates are not high selling.
8. The low rated, not recommended products should be discontinued.
9. Clothes that are recommended, even though they might be rated lowly, should be stocked for all sizes.


## Model Building Conclusions

### Hierarchical Clustering:
1. Fabric, Length, Color, Feel & Fit are essential categories to base recommendations on.
2. Dresses and Tops are a safe bet anytime to show as recommendations as well.

### LDA Model:
3. Fit, Fabric, Size, Top and Dresses are the LDA categories to base suggestions on what to display next.
4. Color, Fit and Design play a major role in what clothes are rated well as per this model.

### Comparison Cloud:
5. According to the comparison cloud, Return, Fit, Material and Disappoint are keywords to look out for in the reviews to predict which products will be recommended.
6. It’s important to adhere to a standard sizing chart and improve quality of material, if feasible.

### Polarized Plot:
7. Polarized plot shows that the one differentiator that can predict whether the clothes fit well or not is the Fit or Size.
8. In most of the cases, if a customer buys a standard size, and it fits as expected, then they are marked as recommended, if not, as not recommended.

### Word Associations:
9. The best type of suggestion for Dresses is other types of Dresses.
10. A good suggestion for someone looking for Bottoms will be Tops as they are generally brought together.
11. Similarly, suggestions can be shown for Bottoms when someone is browsing for Tops as well.
12. Different types of Jackets can be suggested while looking for Jackets.

### Bi-Grams: 
13. Bad/ Odd Fit and Poor Quality are the reasons why a dress was not recommended.
14. Seasonal Clothes and Tops are a big draw in recommended clothes. Size, Fit, Quality were good.
15. Price is reasonable.


## Supervised Model Building Conclusions

### CART Model:
1. Return is a split criteria.
2. Size is the major reason why an item is returned.
3. Length of the item is not as displayed on the website, which leads to some dissatisfaction.
4. When the word ‘disappoint’ is used, fabric and color reason why.

### Random Forest:
5. Return is the factor that is the differentiator to decide, if based on a review, the product is recommended or not.
6. Dress & Top figure highly, which means they are our best selling items and hence, highly reviewed.
7. Size, Fit, Fabric & Color are very important in deciding if a person will return a product or not.
8. Perfect, love & great, all positively associated words figure in the top 10 nodes, which makes sense as around 8 out of 10 women recommend the clothes on the website.
9. Disappoint and huge, words with mostly negative connotations also figure on top, which means that overall, a good selection of recommended and not recommended products are sampled.

Both CART & Random Forest models show that Return, Disappoint & Huge are the watch words to categorize if a reviewer will recommend the product or not.

## Suggestions: 

1. Dresses and Tops are the best selling products with overwhelmingly positive sentiments associated with them. It makes sense to stock them in all sizes, designs and colors to move the products faster. This improves customer satisfaction, helps the ecommerce site stock newer products and provides more variety for the consumer.

2. Dresses and Jackets are two major categories of clothes that the customers look for, for a single item purchase. As per the review analysis, the website stocks a good range of both these products. Grouping different designs of these categories as suggestions is a good idea.

3. Complementary items like Tops and Bottoms that are brought as a pair should be suggested at every phase of browsing for any one of these two products. Discounts, if a top and bottom pair is brought together will improve customer loyalty and double the sales on the website from that customer.

4. Reviewers suggest that the prices, especially during a sale are fair. So the following can be implemented:

a. Discounts if a pair of complementary items, like a Top-Bottom Pair is brought together

b. A buy-One-Get-One free offer on a slow moving item like ‘Trendy Clothes’ or ‘Intimates’. It will clear warehouse stocks and might improve rating of these items if more people buy them

c. Dresses & Tops should be displayed prominently for any new users who browse the website or app.

d. Seasonal Clothes have positive implications so a Summer Sensation or Winter Winner offers improve sales with minimal money spent on publicity

5. Two major suggestions for the manufacturers are:

a. Ask the manufacturers to adhere to a strict sizing policy as size and fit is major concern for all negatively reviewed and not-recommended products. This will not increase the manufacturing costs and hence affect prices in any way but has a major positive impact on customer satisfaction levels and trust.

b. Suggest that the manufacturers use better quality of fabric as another major concern for lowly rated clothes is that the products “look cheap”. A marginal cost increase can be accepted if it leads to better quality.
