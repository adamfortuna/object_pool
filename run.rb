require 'rspec_factory'
require 'java'
require File.join("vendor", "commons-pool-1.6.jar")
import org.apache.commons.pool.impl.GenericObjectPool

# Takes a BasePoolableObjectFactory
@@pool = GenericObjectPool.new(RspecFactory.new)

@@pool.setMaxActive(10)
@@pool.setMinIdle(5)
@@pool.setMaxIdle(10)
@@pool.setTestOnBorrow(false)
@@pool.setTimeBetweenEvictionRunsMillis(10000)

sleep(100)