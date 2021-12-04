# Arylic TCP UART Command-Line-Tool

```
usage: arylic-uart [option] ... 

A small CLI tool to interact with Arylic devices via the UART TCP API.

 Required:
 -c, --cmd VALUE                             The command you want to send, e.g. MCU+PAS+RAKOIT:VER
 -i, --ip VALUE                              IP of the Arylic device you want to send the command to

 Optional:
 -h, --help                                  Show this help message.
```

Will print the response when everything went well.

## UART API Docs

- https://web.archive.org/web/20211204170758/https://developer.arylic.com/download/SA50_TCP_API.pdf
- https://drive.google.com/file/d/1gOb4VBruyJgaBZJHClV6dEkoiwf5hkzE/view
- https://forum.arylic.com/t/latest-api-documents-and-uart-protocols/534