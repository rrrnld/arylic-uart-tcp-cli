(declare-project
  :name "Arylic TCP UART API"
  :description "A small CLI tool to interact with the arylic UART API via TPC." 

  # Optional urls to git repositories that contain required artifacts.
  :dependencies ["https://github.com/janet-lang/spork"])

(declare-executable
 :name "arylic-uart"
 :entry "main.janet")
