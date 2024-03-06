-- importacion de FFI
{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

-- Asi usamos la funcion que queremos dentro del archivo de c 
foreign import ccall "sumar" c_sumar :: Double -> Double -> Double
foreign import ccall "restar" c_restar :: Double -> Double -> Double
foreign import ccall "multiplicar" c_multiplicar :: Double -> Double -> Double
foreign import ccall "dividir" c_dividir :: Double -> Double -> Double

main :: IO ()
main = do
    let a = 10
        b = 5
        resultadoSuma = c_sumar a b
        resultadoResta = c_restar a b
        resultadoMultiplicacion = c_multiplicar a b
        resultadoDivision = c_dividir a b
    putStrLn $ "Resultado de la suma: " ++ show resultadoSuma
    putStrLn $ "Resultado de la resta: " ++ show resultadoResta
    putStrLn $ "Resultado de la multiplicación: " ++ show resultadoMultiplicacion
    putStrLn $ "Resultado de la división: " ++ show resultadoDivision
    