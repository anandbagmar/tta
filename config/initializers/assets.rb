# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version    = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( comparative_analysis_form.js )
Rails.application.config.assets.precompile += %w( comparative_analysis.css )
Rails.application.config.assets.precompile += %w( compare_runs_form.js )
Rails.application.config.assets.precompile += %w( compare_runs.css )
Rails.application.config.assets.precompile += %w( compare_runs_form.js )
Rails.application.config.assets.precompile += %w( compare_runs.css )
Rails.application.config.assets.precompile += %w( defect_analysis_form.js )
Rails.application.config.assets.precompile += %w( defect_analysis.css )
Rails.application.config.assets.precompile += %w( upload_controller.js )
Rails.application.config.assets.precompile += %w( execution_trends.js )
Rails.application.config.assets.precompile += %w( compare_runs_table.js )
Rails.application.config.assets.precompile += %w( pyramid_visualization.js )
Rails.application.config.assets.precompile += %w( defect_analysis.js )