local Translations = {
    error = {
        you_dont_have_a_cryptostick = 'No tienes un cryptostick',
        cryptostick_malfunctioned = 'El criptostick ha funcionado mal'
    },
    success = {
        you_have_exchanged_your_cryptostick_for = 'Has cambiado tu Cryptostick por: %{amount} RX Coin(|s)'
    },
    credit = {
        there_are_amount_credited = '¡Hay %{amount} RX Coin(s) acreditados!',
        you_have_qbit_purchased = 'Has comprado %{dataCoins} RX Coin(s)!'
    },
    debit = {
        you_have_sold = 'Has vendido %{dataCoins} RX Coin(s)!'
    },
    text = {
        enter_usb = '[E] - Introducir USB',
        system_is_rebooting = 'El sistema se está reiniciando - %{rebootInfoPercentage} %',
        you_have_not_given_a_new_value = 'No ha dado un nuevo valor .. Valores actuales: %{crypto}',
        this_crypto_does_not_exist = 'Este Crypto no existe :(, disponible: RX Coin',
        you_have_not_provided_crypto_available_qbit = 'No ha proporcionado Crypto, disponible: RX Coin',
        the_qbit_has_a_value_of = 'El RX Coin tiene un valor de: ${crypto}',
        you_have_with_a_value_of = 'Tienes: %{playerPlayerDataMoneyCrypto} RX Coin(s), con un valor de: %{mypocket},-'
    }
}

if GetConvar('rx_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
