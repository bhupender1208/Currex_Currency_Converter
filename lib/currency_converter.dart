import 'package:flutter/material.dart';

class CurrencyConvertorMaterialPage extends StatefulWidget {
  const CurrencyConvertorMaterialPage({super.key});

  @override
  State<CurrencyConvertorMaterialPage> createState() =>
      _CurrencyConvertorMaterialPageState();
}

class _CurrencyConvertorMaterialPageState
    extends State<CurrencyConvertorMaterialPage> {
  static const _blue = Color(0xFF075CE5);
  static const _lightBlue = Color(0xFF32A9F5);
  static const _currencies = [
    _CurrencyOption(code: 'USD', name: 'US Dollar', flag: '🇺🇸', rate: 95.15),

    _CurrencyOption(
      code: 'SAR',
      name: 'Saudi Riyal',
      flag: '🇸🇦',
      rate: 25.37,
    ),
    _CurrencyOption(
      code: 'RUB',
      name: 'Russian Ruble',
      flag: '🇷🇺',
      rate: 1.18,
    ),
    _CurrencyOption(
      code: 'CNY',
      name: 'Chinese Yuan',
      flag: '🇨🇳',
      rate: 14.28,
    ),
    _CurrencyOption(code: 'AED', name: 'UAE Dirham', flag: '🇦🇪', rate: 25.90),

    _CurrencyOption(
      code: 'CAD',
      name: 'Canadian Dollar',
      flag: '🇨🇦',
      rate: 67.71,
    ),
  ];

  final TextEditingController textEditingController = TextEditingController();
  _CurrencyOption selectedCurrency = _currencies.first;
  double? result;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void convert() {
    final amount = double.tryParse(textEditingController.text.trim());
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid ${selectedCurrency.code} amount.',
          ),
        ),
      );
      return;
    }

    setState(() {
      result = amount * selectedCurrency.rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF568BA3),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          final isCompact = constraints.maxWidth <= 600;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        const Color(0xAA4B91B0),
                        BlendMode.srcATop,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF3D7590).withValues(alpha: 0.62),
                        const Color(0xFF79B4C7).withValues(alpha: 0.68),
                      ],
                    ),
                  ),
                ),
              ),
              if (isWide) ...[
                Positioned(
                  left: constraints.maxWidth * 0.105,
                  top: constraints.maxHeight * 0.28,
                  child: const _CurrencySymbol(symbol: r'$'),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.095,
                  top: constraints.maxHeight * 0.57,
                  child: const _CurrencySymbol(symbol: '€'),
                ),
                Positioned(
                  right: constraints.maxWidth * 0.12,
                  top: constraints.maxHeight * 0.31,
                  child: const _CurrencySymbol(symbol: '₽'),
                ),
                Positioned(
                  right: constraints.maxWidth * 0.095,
                  top: constraints.maxHeight * 0.63,
                  child: const _CurrencySymbol(symbol: '¥'),
                ),
              ],
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 920,
                        minHeight: (constraints.maxHeight - 48).clamp(
                          0,
                          double.infinity,
                        ),
                      ),
                      child: Column(
                        key: const ValueKey('currency-page-content'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: isWide ? 144 : 112,
                            height: isWide ? 136 : 108,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9F6FF),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x44305670),
                                  blurRadius: 28,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.currency_rupee,
                              size: isWide ? 76 : 60,
                              color: _blue,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Currency Convertor',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isWide ? 46 : 34,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                              shadows: const [
                                Shadow(
                                  color: Color(0x33405260),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Convert any currency to INR instantly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE4F2FA),
                              fontSize: isWide ? 21 : 16,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            key: const ValueKey('currency-amount-card'),
                            width: double.infinity,
                            padding: EdgeInsets.all(
                              isWide
                                  ? 30
                                  : isCompact
                                  ? 12
                                  : 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFEAF5FF,
                              ).withValues(alpha: 0.94),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFFD8EEFF),
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33365066),
                                  blurRadius: 24,
                                  offset: Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AMOUNT IN ${selectedCurrency.code}',
                                  style: TextStyle(
                                    color: Color(0xFF536D85),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: isCompact ? 5 : 8),
                                Container(
                                  height: isCompact ? 48 : 58,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7FBFF),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: const Color(0xFFB7D0E5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 124,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<_CurrencyOption>(
                                            value: selectedCurrency,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Color(0xFF647C91),
                                            ),
                                            selectedItemBuilder: (context) =>
                                                _currencies
                                                    .map(
                                                      (currency) => Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '${currency.flag}  ${currency.code}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xFF334B61,
                                                                ),
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            items: _currencies
                                                .map(
                                                  (
                                                    currency,
                                                  ) => DropdownMenuItem(
                                                    value: currency,
                                                    child: Text(
                                                      '${currency.flag}  ${currency.code} - ${currency.name}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (currency) {
                                              if (currency == null) return;
                                              setState(() {
                                                selectedCurrency = currency;
                                                result = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 44,
                                        width: 1.5,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        color: const Color(0xFFB7D0E5),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: textEditingController,
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                          style: const TextStyle(
                                            color: Color(0xFF344C63),
                                            fontSize: 18,
                                          ),
                                          decoration: InputDecoration(
                                            hintText:
                                                'Enter amount in ${selectedCurrency.code}',
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF73879A),
                                            ),
                                            border: InputBorder.none,
                                            isCollapsed: true,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Clear amount',
                                        onPressed: () {
                                          textEditingController.clear();
                                          setState(() {
                                            result = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Color(0xFF9BAEBE),
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isCompact ? 6 : 10),
                                Text(
                                  'Approx. fixed rate: 1 ${selectedCurrency.code} = ₹${selectedCurrency.rate.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFF647C91),
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: isCompact ? 7 : 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: isCompact ? 50 : 60,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [_blue, _lightBlue],
                                      ),
                                      borderRadius: BorderRadius.circular(19),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x443073D4),
                                          blurRadius: 16,
                                          offset: Offset(0, 7),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton.icon(
                                      onPressed: convert,
                                      icon: const Icon(
                                        Icons.swap_horiz_rounded,
                                        size: 32,
                                      ),
                                      label: const Text('Convert to INR'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        shadowColor: Colors.transparent,
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            19,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: isWide ? 440 : double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: isWide ? 34 : 24,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFC9F7E9,
                              ).withValues(alpha: 0.96),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE2FFF5),
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x6655D8B8),
                                  blurRadius: 25,
                                  offset: Offset(0, 9),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '🇮🇳',
                                  style: TextStyle(fontSize: 42),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'INR',
                                      style: TextStyle(
                                        color: Color(0xFF244A4A),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '₹ ${(result ?? 0).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: const Color(0xFF123C38),
                                        fontSize: isWide ? 35 : 27,
                                        fontWeight: FontWeight.w800,
                                        height: 1.15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CurrencyOption {
  const _CurrencyOption({
    required this.code,
    required this.name,
    required this.flag,
    required this.rate,
  });

  final String code;
  final String name;
  final String flag;
  final double rate;
}

class _CurrencySymbol extends StatelessWidget {
  const _CurrencySymbol({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.13),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          color: Color(0x99E4F7FF),
          fontSize: 38,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
