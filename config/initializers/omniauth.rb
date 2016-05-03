Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '1560477190918320', '6bfcab1d0eb302283a76ec02782caa80',
  {
      :image_size => 'original'
  }

  provider :google_oauth2, '118581444224-gqiag2q8ivqpa0m8o1rit1u91fgahgh7.apps.googleusercontent.com',
                            '2EPKjQo4PtwXM5zvsMTbcdKv'

  provider :twitter, '872u8kwSfDqP0sAQ1d1zOV6uO', 'mIc0TVvIQw0ejQ3ZJSIEn1sRhibieMXs8x42KvCIcc4NOLIAir',
 {
     :secure_image_url => 'true',
     :image_size => 'original',
     :authorize_params => {
         :force_login => 'true',
         :lang => 'sp'
     }
 }

end