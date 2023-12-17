ActiveAdmin.register Player do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :age, :gender, offer_ids: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :age
      f.input :gender, :as => :select, collection: Player::GENDERS, input_html: {style:'width:40%'}

      f.input :offers, :as => :select, collection: Offer.all, input_html: {style:'width:40%; height: 200px;'}
    end
    
    f.actions
  end

  show do |player|
    attributes_table do 
      row :id
      row :email
      row :age
      row :gender
    end

    attributes_table_for player.offers do
      row :title
      row :target_age
      row :target_gender
      row :max_age
      row :min_age
    end      

  end
  
end
