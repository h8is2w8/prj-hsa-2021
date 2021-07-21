require 'roda'
require 'net/http'
require 'securerandom'

GA_TRACKING_ID = 'UA-202809167-1'
SESSION_SECRET = 'ebe604e4d285fdf51291316931acd1e3e493f74d99b834775cbd85ba5bb24b64be1663f36a8d3eeb2df81ecc25bd58edd8ef988bed757794fa81097f641bbae0'

class HelloWorld < Roda
  plugin :sessions, secret: SESSION_SECRET

  route do |r|
    r.root do
      user_id = r.session['user_id'] ||= SecureRandom.uuid || r.persist_session
      track_event user_id, "Offline", "Example action", "Example label", "123"
      home_page user_id
    end
  end

  def track_event client_id, category, action, label, value
    Net::HTTP.post_form(
      URI("http://www.google-analytics.com/collect"),
      v:   "1",             # API Version
      tid: GA_TRACKING_ID,  # Tracking ID / Property ID
      cid: client_id,       # Client ID
      t:   "event",         # Event hit type
      ec:  category,        # Event category
      ea:  action,          # Event action
      el:  label,           # Event label
      ev:  value            # Event value
    )
  end

  def home_page(user_id=1)
  <<~TXT
    <html>
    <body>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=#{GA_TRACKING_ID}"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', "#{GA_TRACKING_ID}", { 'user_id': "#{user_id}" });
    </script>
    HELLO WORLD!
    </body>
    </html>
  TXT
  end
end

run HelloWorld.freeze.app

