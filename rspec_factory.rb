require 'java'
require File.join("vendor", "commons-pool-1.6.jar")
import org.apache.commons.pool.BasePoolableObjectFactory

class RspecFactory < BasePoolableObjectFactory
  def makeObject
    start = Time.now
    @sandbox = org.jruby.embed.ScriptingContainer.new(
      org.jruby.embed.LocalContextScope::SINGLETHREAD, # No variable collisions across runs
      org.jruby.embed.LocalVariableBehavior::PERSISTENT # State is persisted for this one objects call
    )
    @sandbox.setCompatVersion(org.jruby.CompatVersion::RUBY1_9)
    @sandbox.run_scriptlet(@@rspec)
    log("created a new RspecFactory in #{Time.now-start}s")
  end

  private

  def log(message)
    puts "#{message} - active: #{@@pool.getNumActive} - idle: #{@@pool.getNumIdle}"
  end

  @@rspec = <<-RUBY
    require 'rubygems'
    require 'bundler/setup'
    require 'rspec'
  RUBY
end