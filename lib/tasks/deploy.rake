#Deploy and rollback on Heroku in staging and production

class RakeHerokuDeployer
  def initialize app_env
    @app = ENV["#{app_env.to_s.upcase}_APP"]
  end

  def run_migrations
    push; turn_app_off; migrate; restart; turn_app_on; tag;
  end

  def deploy
    push; restart; tag;
  end

  def rollback
    turn_app_off; push_previous; restart; turn_app_on;
  end

  private

  def push
    current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
    branch_to_branch = (current_branch.length > 0) ? "#{current_branch}:master" : ""
    puts 'Deploying site to Heroku ...'
    puts "git push -f git@heroku.com:#{@app}.git #{branch_to_branch}"
    puts `git push -f git@heroku.com:#{@app}.git #{branch_to_branch}`
  end

  def restart
    puts 'Restarting app servers ...'
    Bundler.with_clean_env { puts `heroku restart --app #{@app}` }
  end

  def tag
    release_name = "#{@app}_release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push --tags git@heroku.com:#{@app}.git`
  end

  def migrate
    puts 'Running database migrations ...'
    Bundler.with_clean_env { puts `heroku run 'bundle exec rake db:migrate' --app #{@app}` }
  end

  def turn_app_off
    puts 'Putting the app into maintenance mode ...'
    Bundler.with_clean_env { puts `heroku maintenance:on --app #{@app}` }
  end

  def turn_app_on
    puts 'Taking the app out of maintenance mode ...'
    Bundler.with_clean_env { puts `heroku maintenance:off --app #{@app}` }
  end

  def push_previous
    prefix = "#{@app}_release-"
    releases = `git tag`.split("\n").select { |t| t[0..prefix.length-1] == prefix }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."

      puts "Checking out '#{previous_release}' in a new branch on local git repo ..."
      puts `git checkout #{previous_release}`
      puts `git checkout -b #{previous_release}`

      puts "Removing tagged version '#{previous_release}' (now transformed in branch) ..."
      puts `git tag -d #{previous_release}`
      puts `git push git@heroku.com:#{@app}.git :refs/tags/#{previous_release}`

      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts `git push git@heroku.com:#{@app}.git +#{previous_release}:master --force`

      puts "Deleting rollbacked release '#{current_release}' ..."
      puts `git tag -d #{current_release}`
      puts `git push git@heroku.com:#{@app}.git :refs/tags/#{current_release}`

      puts "Retagging release '#{previous_release}' in case to repeat this process (other rollbacks)..."
      puts `git tag -a #{previous_release} -m 'Tagged release'`
      puts `git push --tags git@heroku.com:#{@app}.git`

      puts "Turning local repo checked out on master ..."
      puts `git checkout master`
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end
end

namespace :deploy do
  namespace :production do
    task :migrations do
      deployer = RakeHerokuDeployer.new(:production)
      deployer.run_migrations
    end

    task :rollback do
      deployer = RakeHerokuDeployer.new(:production)
      deployer.rollback
    end
  end

  task :production do
    deployer = RakeHerokuDeployer.new(:production)
    deployer.deploy
  end
end

#Added to simplify process and run migrations every time. Just run rake deploy.
task :deploy do
  deployer = RakeHerokuDeployer.new("production")
  deployer.run_migrations
end
