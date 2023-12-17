ActiveAdmin.register Tag do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :slug
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs do 
      f.input :name
      f.input :slug, input_html: {disabled: "disabled"}
    end
    f.actions
  end
  
end
