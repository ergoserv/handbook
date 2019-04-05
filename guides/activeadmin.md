# ActiveAdmin

## Template

Recommended order of blocks

```ruby
ActiveAdmin.register User do
  config.sort_order = 'name_asc'

  menu label: "My People"

  belongs_to :tenant

  permit_params :email, :name, :password

  actions :all, except: [:update, :destroy]
  batch_action :destroy, false

  preserve_default_filters!
  filter :email
  remove_filter :id

  scope :all, default: true
  scope :active

  index do
  end

  csv do
  end

  show do
  end

  form do
  end

  sidebar :details do
  end

  sidebar :help # app/views/admin/posts/_help_sidebar.html.erb

  action_item :view, only: :show do
  end

  batch_action :flag do |ids|
  end

  collection_action :import_csv, method: :post do
  end

  member_action :lock, method: :put do
  end

  controller do
  end
end
```

## References

* https://activeadmin.info
* https://github.com/activeadmin/activeadmin
