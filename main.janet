(import spork/argparse)

# Some documentation can be found at the following URLs:
# - https://web.archive.org/web/20211204170758/https://developer.arylic.com/download/SA50_TCP_API.pdf
# - https://forum.arylic.com/t/latest-api-documents-and-uart-protocols/534/3

(defn encode-payload
  "Encodes the command payload as described in the documentation URL, page 1"
  [command]
  (-> 
   (buffer @"\x18\x96\x18\x20") # header
   (buffer/push-word (length command))
   (buffer/push-word (sum command))
   (buffer/push @"\x00\x00\x00\x00\x00\x00\x00\x00") # reserved
   (buffer/push-string command)
   (buffer/push-string "&")))

(comment
  # to decode a payload, simply call `string` :)
  # example taken from the first page of the pdf
  (string "\x18\x96\x18\x20\x0b\x00\x00\x00\xc1\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4d\x43\x55\x2b\x56\x4f\x4c\x2b\x30\x35\x30") # "\x18\x96\x18 \v\0\0\0\xC1\x02\0\0\0\0\0\0\0\0\0\0MCU+VOL+050"
  (encode-payload "MCU+VOL+050")                                                                                                         # @"\x18\x96\x18 \v\0\0\0\xC1\x02\0\0\0\0\0\0\0\0\0\0MCU+VOL+050&"
  )

(def options
  ["A small CLI tool to interact with Arylic devices via the UART TCP API."
   "device" {:kind :option
             :help "IP or URL (without protocol) of the Arylic device you want to send the command to"
             :short "d"
             :required true}
   "cmd" {:kind :option
          :help "The command you want to send, e.g. MCU+PAS+RAKOIT:VER"
          :short "c"
          :required true}])

(defn main [& args]
  (let [parsed (argparse/argparse ;options)
        payload (encode-payload (parsed "cmd"))
        res @""]
    (with [socket (net/connect (parsed "device") "8899" :stream)]
      # (printf "Connected to ip %s at socket %q!" (parsed "ip") socket)
      (:write socket payload 5)
      # (printf "Wrote payload %q" payload)
      (:read socket 1024 res 5)
      (print (string/slice res 20 -2)))))
