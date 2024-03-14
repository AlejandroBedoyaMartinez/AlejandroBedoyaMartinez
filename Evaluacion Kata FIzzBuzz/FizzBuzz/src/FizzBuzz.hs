module FizzBuzz where

numeroPrimo :: Int -> Bool
numeroPrimo n
    | n <= 1 = False
    | otherwise = null [x | x <- [2..floor(sqrt(fromIntegral n))], n `mod` x == 0]

fizzbuzz :: Int -> String
fizzbuzz n
    | numeroPrimo n = "FizzBuzz!"
    | otherwise = escribirNumero n

escribirNumero :: Int -> String
escribirNumero n
    | n < 0 || n > 1000000 = "Numero fuera de rango"
    | n == 0 = "cero"
    | n == 20 = "veinte"
    | n == 100 = "cien"
    | n < 20 = menorQueVeinte !! (n - 1)
    | n < 30 = "veinti" ++ menorQueVeinte !! (n - 21)
    | n < 100 = decenas !! ((n `div` 10) - 2) ++ if n `mod` 10 /= 0 then " y " ++ menorQueVeinte !! ((n `mod` 10) - 1) else ""
    | n < 1000 = centenas !! ((n `div` 100) - 1) ++ if n `mod` 100 /= 0 then " " ++ escribirNumero (n `mod` 100) else ""
    | n < 2000 = "mil" ++ if n `mod` 1000 /= 0 then " " ++ escribirNumero (n `mod` 1000) else ""
    | n < 1000000 = millares ++ if n `mod` 1000 /= 0 then " " ++ escribirNumero (n `mod` 1000) else ""
    | otherwise = "Número no soportado"
    where
        menorQueVeinte = ["uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", "once", "doce", "trece", "catorce", "quince", "dieciseis", "diecisiete", "dieciocho", "diecinueve"]
        decenas = ["veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"]
        centenas = ["ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"]
        millares = escribirNumero (n `div` 1000) ++ " mil"

