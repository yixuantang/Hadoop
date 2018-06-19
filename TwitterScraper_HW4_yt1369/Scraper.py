#!/usr/bin/env python

'''
June 2018
Created by TYX
'''
import sys,twitter
import csv
import tweepy

#enter your twitter API details below
consumer_key = ''
consumer_secret = ''
access_token_key = ''
access_token_secret = ''

auth = tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token_key,access_token_secret)
api=tweepy.API(auth)


def user_tweet(screen_name):

	alltweets = []	
	new_tweets = api.user_timeline(screen_name = screen_name,count=100)
	alltweets.extend(new_tweets) #save all tweets
	newest = alltweets[0].id

	while len(new_tweets) > 0:
		print "getting maximum 100 recent tweets" 
	
		new_tweets = api.user_timeline(screen_name = screen_name,count=100,since_id=newest)
		
		alltweets.extend(new_tweets)
		
		newest = alltweets[0].id
		
		print "total %s tweets downloaded " % (len(alltweets))

	outtweets = [[tweet.id_str, tweet.created_at, tweet.text.encode("utf-8")] for tweet in alltweets]
	
	#write the csv	
	with open('%s_recent100tweets.csv' % screen_name, 'wb') as f:
		writer = csv.writer(f)
		writer.writerow(["tweet_id","created_at","text"])
		writer.writerows(outtweets)
	pass

username = raw_input("\nEnter the user name, for example try realDonaldTrump:")
if __name__ == '__main__':
	user_tweet(username)
