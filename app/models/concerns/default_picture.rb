module DefaultPicture
    extend ActiveSupport::Concern

    def self.picture
        "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png"
    end
end