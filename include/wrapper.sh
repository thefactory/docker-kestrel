#/bin/bash -e

# Generate the config and start kestrel

# Use a wrapper script so we can parameterize config settings later

cat <<- EOF > /opt/kestrel/config.scala
	import com.twitter.conversions.storage._
	import com.twitter.conversions.time._
	import com.twitter.logging.config._
	import com.twitter.ostrich.admin.config._
	import net.lag.kestrel.config._

	new KestrelConfig {
	  listenAddress = "0.0.0.0"
	  memcacheListenPort = 22133
	  textListenPort = 2222
	  thriftListenPort = 2229

	  queuePath = "/data"

	  clientTimeout = 30.seconds

	  expirationTimerFrequency = 1.second

	  maxOpenTransactions = 100

	  // default queue settings:
	  default.defaultJournalSize = 16.megabytes
	  default.maxMemorySize = 128.megabytes
	  default.maxJournalSize = 1.gigabyte

	  admin.httpPort = 2223

	  admin.statsNodes = new StatsConfig {
	    reporters = new TimeSeriesCollectorConfig
	  }

	  loggers = new LoggerConfig {
	    level = Level.INFO
	    handlers = List(new ConsoleHandlerConfig)
	  }
	}
EOF

exec 2>&1
exec java -jar /opt/kestrel/kestrel.jar -f /opt/kestrel/config.scala