package robotlegs.extensions.facebook.impl.services.user {
import com.facebook.graph.Facebook;

import flash.events.IEventDispatcher;

import robotlegs.bender.framework.api.IContext;

import robotlegs.bender.framework.api.ILogger;
import robotlegs.extensions.facebook.api.services.user.IFacebookUserGetBasicDataService;
import robotlegs.extensions.facebook.impl.events.FacebookEvent;
import robotlegs.extensions.facebook.impl.model.FacebookUser;

/**
 * @author nahuel.scotti @ gmail.com
 */
public class FacebookUserGetBasicDataService implements IFacebookUserGetBasicDataService {
    [Inject]
    public var user:FacebookUser;
    [Inject]
    public var context:IContext;
    [Inject]
    public var dispatcher:IEventDispatcher;

    private var _logger:ILogger;

    public function getUserBasicData():void {
        _logger = context.getLogger(this);
        _logger.info('Get Facebook User basic data...');
        Facebook.api('/me', onUserBasicData, {fields:'id,picture,name,first_name,last_name,link,username,gender,timezone,locale,updated_time,email'});
    }

    private function onUserBasicData(success:Object, fail:Object):void {
        fail = null;

        var data:Object = success;
        _logger.info('Get Facebook User basic data success!');

        user.gender = data.gender;
        user.name = data.name;
        user.timezone = data.timezone;
        user.last_name = data.last_name;
        user.id = data.id;
        user.first_name = data.first_name;
        user.username = data.username;
        user.updated_time = data.updated_time;
        user.locale = data.locale;
        user.link = data.link;
        user.email = data.email;
        user.picture = data.picture;

        dispatcher.dispatchEvent(new FacebookEvent(FacebookEvent.USER_BASIC_DATA_CHANGE, user));
    }
}
}