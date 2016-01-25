global with sharing class FacebookFavoriteController {
//extends FacebookLoginController {
  /*  public static String getAccessToken() {
        return FacebookToken.getAccessToken();
    }

    public FacebookUser me {
        get {
            // Can't set up 'me' in the controller constructor, since the 
            // superclass 'login' method won't have been called!
            if (me == null) {
                String accessToken = getAccessToken();

                // If accessToken is null, it's likely that the page's action 
                // method has not yet been called, so we haven't been to FB to
                // get an access token yet. If this is the case, we can just 
                // leave 'me' as null, since the redirect will happen before
                // HTML is sent back.
                if (accessToken != null) {
                    me = new FacebookUser(accessToken, 'me');                    
                }
            }

            return me;
        } set;
    }

    public Integer favorite {
        get {
            if (favorite == null) {
                String accessToken = getAccessToken();

                if (accessToken != null) {
                    List<Facebook_Favorite__c> favorites = 
                        [SELECT Favorite_Number__c
                            FROM Facebook_Favorite__c
                            WHERE id = :me.id];

                    favorite = (favorites.size() == 0) ? 
                        null : 
                        Integer.valueOf(favorites[0].Favorite_Number__c);
                }
            }

            return favorite;
        } set;
    }

    private FacebookUsers friends { 
        get {
            if (friends == null) {
                String accessToken = getAccessToken();

                if (accessToken != null) {
                    Map<String, String> params = 
                        new Map<String, String>{'fields' => 'id,name'};
                    friends = new FacebookUsers(accessToken, 'me/friends', params);
                }
            }

            return friends;
        } set;
    }

    public List<Facebook_Favorite__c> friendsFavorites {
        get {
            if (friendsFavorites == null) {
                String accessToken = getAccessToken();

                if (accessToken != null) {
                    List<String> friendIDs = new List<String>();

                    // Show my own favorite number, if I have one
                    friendIDs.add(me.id);    

                    for (FacebookUser friend : friends.data) {
                        friendIDs.add(friend.id);
                    }

                    friendsFavorites = [SELECT Name, id, Favorite_Number__c
                        FROM Facebook_Favorite__c
                        WHERE id IN :friendIDs
                        ORDER BY Favorite_Number__c DESC];
                }
            }

            return friendsFavorites;
        } set;
    }

    public PageReference save(){
        if (me == null) {
            throw new FacebookException('Cannot save without a Facebook user!');
        }

        List<Facebook_Favorite__c> favorites = 
            [SELECT Favorite_Number__c
                FROM Facebook_Favorite__c
                WHERE id = :me.id];

        if (favorites.size() == 0) {
            Facebook_Favorite__c newFavorite = new Facebook_Favorite__c(Name = me.name, 
                id = me.id, 
                Favorite_Number__c = favorite);
            insert newFavorite;
        } else {
            favorites[0].Favorite_Number__c = favorite;
            update favorites[0];
        }

        // Force the favorites list to be refreshed so I see my own favorite
        friendsFavorites = null;

        return null;
    }

    public PageReference refreshFriendsFavorites() {
        // Force the friends list to be refreshed
        friends = null;

        // Force the favorites list to be refreshed
        friendsFavorites = null;

        return null;
    }    */
}