class Pixar < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  disable :protection
  
  enable :sessions
    configure :development do
      FB_APP_ID = '151259104968742'
      FB_APP_SECRET = '2e783d93aefa6581e923a62c6054abac'
      FB_APP_URL = 'http://apps.facebook.com/rh-jackson/'
      FB_APP_URL_SHORT = 'http://bit.ly/AuhqSG'
      FRAME_URL = 'http://10.1.10.183:9393/'
      FB_REDIRECT = 'http://apps.facebook.com/rh-jackson/'
      ANALYTICS =  'UA-XXXXX-X'
      CDN = ''
      CDNSSL = ''      
    end
  
    configure :production do
      FB_APP_ID = '180523668723011'
      FB_APP_SECRET = 'c3e564567e4db40afbb2b4bc501827c8'
      FB_APP_URL = 'https://apps.facebook.com/rush-stage/'
      FB_APP_URL_SHORT = 'http://on.fb.me/whsJ5M'
      FRAME_URL = 'https://pixar-quiz.herokuapp.com/'
      FB_REDIRECT = 'https://apps.facebook.com/kinect-rush/'
      ANALYTICS =  'UA-XXXXX-X'
      CDN = ''
      CDNSSL = ''
    end

  match '/' do
    # test
    render '/base/start'
  end

  match '/encrypt' do
    @encryption =  params[:str].encrypt
    render '/base/encrypt'



  end
  
  match '/decrypt' do 
    params[:str].decrypt
  end

end
