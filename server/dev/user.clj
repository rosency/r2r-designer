(ns user
  "Tools for interactive development with the REPL. This file should
   not be included in a production build of the application."
  (:require
    [clojure.java.io :as io]
    [clojure.java.javadoc :refer (javadoc)]
    [clojure.java.jdbc :as jdbc]
    [clojure.pprint :refer (pprint)]
    [clojure.reflect :refer (reflect)]
    [clojure.repl :refer (apropos dir doc find-doc pst source)]
    [clojure.set :as set]
    [clojure.string :as str]
    [clojure.test :as test]
    [clojure.tools.namespace.repl :refer (refresh refresh-all)]
    [clojure.tools.logging :refer (info error debug)]
    [ring.server.standalone :refer :all]
    [ring.middleware.file-info :refer :all]
    [ring.middleware.file :refer :all]
    [server.core :refer :all]
    [server.core.sparqlmap :refer :all]
    [server.system :as system]
    [server.handler :as handler]
    )
  )

;; A Var containing an object representing the application under
;; development."
(def system nil) 
(defn db [] (:db system))

(defn init
  "Creates and initializes the system under development in the Var
  #'system."
  []  
  (alter-var-root #'system
    (constantly (system/system)))
  (let [db-fname "northwind.postgres.sql"]
    ;; (jdbc/db-do-commands (:db system) "DROP SCHEMA PUBLIC CASCADE;")
    ;; (jdbc/db-do-commands (:db system) "CREATE SCHEMA PUBLIC;")
    ;; (doseq [i (sql-commands (sql-script db-fname))] 
    ;;   (debug i)
    ;;   (jdbc/db-do-commands (:db system) true i)
    ;;   )
    )
  )

(defn start-server
  "used for starting the server in development mode from REPL"
  [& [server port]]
  (let [port (if port (Integer/parseInt port) 8080)]
    (reset!
      server (serve 
               #'handler/app
               {:port port
                :init handler/init
                :auto-reload? true
                :destroy handler/destroy
                :join true
                :open-browser? false}
               )
      )
    )
  )

(defn start
  "Starts the system running, updates the Var #'system."
  []
  (start-server (:server system) "3000")
  )

(defn stop-server [server]
  (if @server
    (.stop @server)
    (reset! server nil)
    )
  )

(defn stop
  "Stops the system if it is currently running, updates the Var
  #'system."
  []
  (if (:server system)
    (stop-server (:server system))
    )
  )

(defn go
  "Initializes and starts the system running."
  []
  (init)
  (start)
  :ready)

(defn reset
  "Stops the system, reloads modified source files, and restarts it."
  []
  (stop)
  (refresh :after 'user/go))