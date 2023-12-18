ActiveAdmin.register Offer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :target_age, :max_age, :min_age, :target_gender, tag_ids: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :target_age, :max_age, :min_age, :target_gender]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :title
      f.input :description

      f.input :target_age
      f.input :min_age
      f.input :max_age

      f.input :target_genders, :as => :select, collection: Gender.all, input_html: {style:'width:40%'}
      f.input :tags, :as => :select, collection: Tag.all, input_html: {style:'width:40%;height: 100px;'}
    end
    
    f.actions
  end
end
