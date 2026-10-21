import 'package:flutter/material.dart';

void main() {
  runApp(const EcoCellApp());
}

class EcoCellApp extends StatelessWidget {
  const EcoCellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoCell',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class MyApp extends EcoCellApp {
  const MyApp({super.key});
}

class UsageData {
  final String studentName;
  final String activityType;
  final int dailyHours;
  final int batteryLevel;
  final int targetBattery;
  final bool nightMode;
  final double alertsPerHour;

  const UsageData({
    required this.studentName,
    required this.activityType,
    required this.dailyHours,
    required this.batteryLevel,
    required this.targetBattery,
    required this.nightMode,
    required this.alertsPerHour,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoCell'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Controla el uso de tu celular',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Monitorea tu tiempo de uso, batería y hábitos para evitar distracciones y mejorar tu rendimiento.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF475569),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: [
                    FeatureCard(
                      icon: Icons.note_alt_rounded,
                      title: 'Registrar uso',
                      subtitle: 'Captura tus hábitos diarios.',
                      color: const Color(0xFFDBEAFE),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                    ),
                    FeatureCard(
                      icon: Icons.insights_rounded,
                      title: 'Ver análisis',
                      subtitle: 'Revisa tus resultados.',
                      color: const Color(0xFFDCFCE7),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Primero registra tu información en el formulario.',
                            ),
                          ),
                        );
                      },
                    ),
                    FeatureCard(
                      icon: Icons.lightbulb_rounded,
                      title: 'Recomendaciones',
                      subtitle: 'Aplicar ajustes inteligentes.',
                      color: const Color(0xFFFDE68A),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Activa el modo nocturno y limita tus alertas para mejorar tu enfoque.',
                            ),
                          ),
                        );
                      },
                    ),
                    FeatureCard(
                      icon: Icons.security_rounded,
                      title: 'Salud digital',
                      subtitle: 'Protégete del uso excesivo.',
                      color: const Color(0xFFE9D5FF),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Mantén pausas activas y un nivel de batería seguro.',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomPrimaryButton(
                label: 'Comenzar registro',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _batteryController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  String _activityType = 'Estudio';
  bool _nightMode = false;
  double _alertsPerHour = 4;

  @override
  void dispose() {
    _nameController.dispose();
    _hoursController.dispose();
    _batteryController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrige los datos antes de continuar.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final usageData = UsageData(
      studentName: _nameController.text.trim(),
      activityType: _activityType,
      dailyHours: int.parse(_hoursController.text),
      batteryLevel: int.parse(_batteryController.text),
      targetBattery: int.parse(_targetController.text),
      nightMode: _nightMode,
      alertsPerHour: _alertsPerHour,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos guardados correctamente.'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultsScreen(data: usageData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de uso'),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ingresa tus datos',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  controller: _nameController,
                  label: 'Nombre del estudiante',
                  hint: 'Ej. Ana López',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Escribe tu nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _activityType,
                  decoration: InputDecoration(
                    labelText: 'Actividad principal',
                    prefixIcon: const Icon(Icons.work_outline_rounded),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Estudio', child: Text('Estudio')),
                    DropdownMenuItem(value: 'Trabajo', child: Text('Trabajo')),
                    DropdownMenuItem(
                      value: 'Entretenimiento',
                      child: Text('Entretenimiento'),
                    ),
                    DropdownMenuItem(
                      value: 'Redes sociales',
                      child: Text('Redes sociales'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _activityType = value ?? 'Estudio';
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _hoursController,
                  label: 'Horas diarias de uso',
                  hint: 'Ej. 5',
                  icon: Icons.timer_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa la cantidad de horas';
                    }
                    final hours = int.tryParse(value);
                    if (hours == null || hours < 1 || hours > 16) {
                      return 'El rango válido es de 1 a 16 horas';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        controller: _batteryController,
                        label: 'Batería actual %',
                        hint: 'Ej. 72',
                        icon: Icons.battery_full_rounded,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa el porcentaje';
                          }
                          final percent = int.tryParse(value);
                          if (percent == null ||
                              percent < 10 ||
                              percent > 100) {
                            return 'El rango válido es 10-100';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomInputField(
                        controller: _targetController,
                        label: 'Meta de batería %',
                        hint: 'Ej. 40',
                        icon: Icons.flag_rounded,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa una meta';
                          }
                          final percent = int.tryParse(value);
                          if (percent == null ||
                              percent < 20 ||
                              percent > 100) {
                            return 'La meta debe estar entre 20 y 100';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Modo nocturno',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Switch(
                            value: _nightMode,
                            activeThumbColor: const Color(0xFF2563EB),
                            onChanged: (value) {
                              setState(() {
                                _nightMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nivel de alertas por hora',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Slider(
                        value: _alertsPerHour,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _alertsPerHour.toStringAsFixed(0),
                        activeColor: const Color(0xFF10B981),
                        onChanged: (value) {
                          setState(() {
                            _alertsPerHour = value;
                          });
                        },
                      ),
                      Text(
                        'Valor actual: ${_alertsPerHour.toStringAsFixed(0)} alertas/hora',
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomPrimaryButton(
                  label: 'Guardar y continuar',
                  icon: Icons.check_circle_outline_rounded,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final UsageData data;

  const ResultsScreen({super.key, required this.data});

  Color _statusColor() {
    final risk = _riskIndex();
    if (risk >= 70) return const Color(0xFFDC2626);
    if (risk >= 45) return const Color(0xFFF59E0B);
    return const Color(0xFF16A34A);
  }

  String _statusLabel() {
    final risk = _riskIndex();
    if (risk >= 70) return 'Riesgo alto';
    if (risk >= 45) return 'Riesgo medio';
    return 'Riesgo bajo';
  }

  double _riskIndex() {
    final hoursFactor = data.dailyHours * 4.5;
    final batteryFactor = (100 - data.targetBattery) * 0.8;
    final alertsFactor = data.alertsPerHour * 5.5;
    final nightModeFactor = data.nightMode ? 10 : 0;
    final total = hoursFactor + batteryFactor + alertsFactor + nightModeFactor;
    return total.clamp(0, 100).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final risk = _riskIndex();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resumen del uso actual',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _statusColor().withAlpha(32),
                ),
                child: Column(
                  children: [
                    Text(
                      _statusLabel(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _statusColor(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: risk / 100,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.white,
                      color: _statusColor(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Índice estimado: ${risk.toStringAsFixed(0)} / 100',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      icon: Icons.person,
                      label: 'Estudiante',
                      value: data.studentName,
                      color: const Color(0xFFDBEAFE),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      icon: Icons.phone_android_rounded,
                      label: 'Actividad',
                      value: data.activityType,
                      color: const Color(0xFFDCFCE7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      icon: Icons.timer_outlined,
                      label: 'Horas',
                      value: '${data.dailyHours} h',
                      color: const Color(0xFFFDE68A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      icon: Icons.battery_charging_full_rounded,
                      label: 'Meta',
                      value: '${data.targetBattery}%',
                      color: const Color(0xFFE9D5FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recomendación principal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      risk >= 70
                          ? 'Tu uso está muy por encima del ideal. Te recomendamos limitar notificaciones y activar pausas cada 40 minutos.'
                          : risk >= 45
                          ? 'Tu uso es moderado. Prográmate descansos y reduce tus alertas para mantener mejor enfoque.'
                          : 'Buen balance general. Mantén tu control y usa el modo nocturno para evitar distracciones.',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF334155),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomPrimaryButton(
                label: 'Volver al inicio',
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 28, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0F172A)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class CustomPrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomPrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
