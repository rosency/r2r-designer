(ns server.routes.oracle
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
    [server.core.db :as db]
    [server.core.oracle :refer :all]
    )
  )

(timbre/refer-timbre)

(defn oracle-routes-fn [component]
  (let [api (:oracle-api component)]
    (defroutes oracle-routes
      (POST (str api "/suggest") request
        (let [oracle (:oracle component)
              response nil]
          (str request)))
      (GET (str api "/properties/search") [q :as r] 
        (let [oracle (:oracle component)
              response nil]
          response))
      (GET (str api "/classes/search") [q :as r] 
        (let [oracle (:oracle component)
              response nil]
          response))
      )
    )
  )

