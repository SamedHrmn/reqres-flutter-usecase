# ReqRes API Flutter Use Case

### Known issues
The reqres api auth endpoints I use only return the 400 code in response. Although I tried it with Postman, I did not get any results. I saw a message like "only certain users can register" as an error message. Please let me know if you know what the problem is.

### Project Structure - MVCS

<pre>
     lib--                                  
         |                                       
         |__models                                     
                |__api_response_model.dart
                |__user_model.dart
         |__utilities                           
                |__api_constant.dart
                |__assets_constant.dart        
                |__form_extension.dart
                |__form_validators.dart
                |__locator.dart
                |__shared_pref_helper.dart
                |__string_constant.dart
         |__providers                           
                |__login_provider.dart
                |__register_provider.dart
                |__users_provider.dart
         |__services
                |__api_service.dart
                |__dio_service.dart
         |__views
                |__home_view.dart
                |__login_view.dart
                |__register_view.dart
         |__widgets
                |__app_elevated_button.dart
                |__app_form_field.dart
                |__user_card.dart
               
         main.dart
</pre><br><br>
