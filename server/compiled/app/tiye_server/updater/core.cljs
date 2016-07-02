
(ns tiye-server.updater.core
  (:require [tiye-server.updater.state :as state]
            [tiye-server.updater.task :as task]))

(defn updater [db op op-data state-id op-id op-time]
  (case
    op
    :state/connect
    (state/connect db op-data state-id op-id op-time)
    :state/disconnect
    (state/disconnect db op-data state-id op-id op-time)
    :task/add
    (task/add db op-data state-id op-id op-time)
    :task/rm
    (task/rm db op-data state-id op-id op-time)
    db))
