namespace :spec_parallel do
  task :models do
    sh 'rake parallel:spec[^spec/models]'
  end

  task :controllers do
    sh 'rake parallel:spec[^spec/controllers]'
  end

  task :helpers do
    sh 'rake parallel:spec[^spec/helpers]'
  end
end