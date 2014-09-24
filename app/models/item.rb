class Item < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :swap
  has_one :user, through: :purchase

  # before_create :set_json_default_fields
  before_create :retrieve_nutritionix_api_data
  # before_create :encrypt_attributes, if: :use_privacy_hashing?

  after_update :send_swap_mailer, if: proc { |item| item.swap_id_changed? }

  def self.nutritionix_api_fields
    %W(calcium_dv calories calories_from_fat cholesterol dietary_fiber ingredient_statement iron_dv monounsaturated_fat polyunsaturated_fat protein refuse_pct saturated_fat serving_size_qty serving_size_unit serving_weight serving_weight_grams serving_weight_uom servings_per_container sodium sugars total_carbohydrate total_fat trans_fatty_acid vitamin_a_dv vitamin_c_dv water_grams)
  end

  nutritionix_api_fields.each do |nutrition_field|
    define_method(nutrition_field) do
      ntx_api_nutrition_data && ntx_api_nutrition_data["nf_#{nutrition_field}"]
    end
  end

  def filtered_category
    CategoryDigester.chew(category, name)
  end

  # def upc
  #   ntx_api_nutrition_data['upc']
  # end

private

  def use_privacy_hashing?
    USE_PRIVACY_HASHING && !name.nil?
  end

  # def set_json_default_fields
  #   self.
  # end

  def retrieve_nutritionix_api_data
    unless name.nil?
      api_data = NUTRITIONIX_API.search(name)
      p api_data
      if api_data.blank? || api_data == 'Connection error.'
        return false 
      else
        self.ntx_api_nutrition_data = api_data.delete 'fields'
        self.ntx_api_metadata       = api_data

        if api_data['_score'].to_f < 0.5
          return false 
        else
          return true
        end
      end
    end
  end

  def encrypt_attributes
    aes = OpenSSL::Cipher.new('AES-256-CBC')
    aes.encrypt
    aes.key = SECRET_KEY
    self.name = Base64.encode64(aes.update(name) + aes.final).encode('UTF-8')
    ['brand_name', 'brand_id', 'item_name', 'item_description', '_id', 'keywords', 'nf_ingredient_statement'].each do |field|
      unless ntx_api_nutrition_data.nil? or ntx_api_nutrition_data[field].nil?
        data = ntx_api_nutrition_data[field].to_s
        self.ntx_api_nutrition_data[field] = Base64.encode64(aes.update(data) + aes.final).encode('UTF-8')
      end
    end
  end

  def send_swap_mailer
    UserMailer.replacement_suggestion(self).deliver
  end

  # def decrypt_attribute(data)
  #   aes = OpenSSL::Cipher.new('AES-256-CBC')
  #   aes.decrypt
  #   aes.key = SECRET_KEY
  #   data = Base64.decode64(data).encode('ascii-8bit')
  #   p aes.update(data) + aes.final
  # end

end
