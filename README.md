# 🎯 Quiz App - Flutter con Clean Architecture

Una aplicación de cuestionarios offline construida con Flutter siguiendo los principios de Clean Architecture y usando BLoC para la gestión de estado.

## 📋 Características

- ✅ **Arquitectura Limpia**: Separación clara entre capas (Domain, Data, Presentation)
- 🎮 **Gestión de Estado con BLoC**: Manejo robusto del estado de la aplicación
- ⏱️ **Timer por Pregunta**: 60 segundos para responder cada pregunta
- 🎲 **Preguntas Aleatorias**: Las preguntas se mezclan en cada intento
- 💾 **Almacenamiento Local**: Historial de resultados guardado localmente
- 🎨 **Tema Adaptable**: Se adapta al tema del sistema (claro/oscuro)
- 📱 **100% Offline**: No requiere conexión a internet

## 🏗️ Arquitectura del Proyecto

```
lib/
├── core/               # Configuraciones, constantes, utilidades
├── data/               # Modelos, repositorios, fuentes de datos
├── domain/             # Entidades, casos de uso, interfaces
└── presentation/       # UI, BLoCs, widgets
```

## 🚀 Comenzar

### Prerequisitos

- Flutter SDK 3.0+
- Dart 3.0+

### Instalación

1. **Clonar el repositorio o crear el proyecto**
```bash
flutter create quiz_app
cd quiz_app
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

## 📦 Dependencias Principales

- `flutter_bloc: ^8.1.3` - Gestión de estado
- `equatable: ^2.0.5` - Comparación de objetos
- `shared_preferences: ^2.2.2` - Almacenamiento local
- `dartz: ^0.10.1` - Programación funcional
- `get_it: ^7.6.4` - Inyección de dependencias
- `intl: ^0.18.1` - Formateo de fechas

## 🎮 Cómo Usar

### 1. Pantalla Principal (Home)
- Ver historial de intentos anteriores
- Iniciar un nuevo quiz

### 2. Pantalla de Quiz
- Responder preguntas de opción múltiple
- Cada pregunta tiene 60 segundos
- Las respuestas correctas se marcan en verde
- Las respuestas incorrectas se marcan en rojo
- No se puede cambiar la respuesta una vez seleccionada

### 3. Pantalla de Resultados
- Ver puntuación final
- Ver precisión (%)
- Ver tiempo total
- Opción de jugar de nuevo o volver al inicio

## 📝 Estructura de Datos

### JSON de Preguntas (`assets/data/questions.json`)

```json
[
  {
    "id": 1,
    "question": "¿Cuál es la capital de Ecuador?",
    "options": ["Quito", "Guayaquil", "Cuenca", "Ambato"],
    "correctAnswer": 0
  }
]
```

### Modelo de Resultado

```dart
QuizResult(
  score: int,              // Puntuación total
  totalQuestions: int,     // Total de preguntas
  correctAnswers: int,     // Respuestas correctas
  incorrectAnswers: int,   // Respuestas incorrectas
  totalTimeInSeconds: int, // Tiempo total en segundos
  date: DateTime,          // Fecha del intento
)
```

## 🎨 Personalización

### Colores
Edita `lib/core/constants/app_colors.dart` para cambiar los colores de la aplicación.

### Tiempo por Pregunta
Edita `lib/core/constants/app_dimensions.dart` y modifica `questionTimeInSeconds`.

### Agregar Más Preguntas
Edita `assets/data/questions.json` y agrega más objetos al array siguiendo el formato establecido.

## 🧪 Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar con cobertura
flutter test --coverage
```

## 📱 Compilación

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🏆 Sistema de Puntuación

- Cada respuesta correcta: **10 puntos**
- Tiempo agotado o respuesta incorrecta: **0 puntos**
- Puntuación máxima: **Total de preguntas × 10**

## 🔄 Flujo de la Aplicación

```
Home → Quiz → Result
  ↓      ↓       ↓
  ↓      ↓    ← → Home
  ↓   ← ← ←      ↓
  ← ← ← ← ← ← ← ←
```

## 🛠️ Solución de Problemas

### Las preguntas no se cargan
- Verifica que `assets/data/questions.json` esté correctamente ubicado
- Verifica que `pubspec.yaml` incluya la carpeta `assets/data/` en assets

### El historial no se guarda
- Asegúrate de tener permisos de almacenamiento
- Verifica que `shared_preferences` esté correctamente inicializado

## 📄 Licencia

Este proyecto está bajo la Licencia Dennis Caisa.

## 👨‍💻 Autor
DENNIS CAISA
Desarrollado siguiendo Clean Architecture y mejores prácticas de Flutter.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Soporte

Si encuentras algún problema o tienes preguntas, por favor abre un issue en el repositorio.
O escribe a mi correo "denniscaisa@gmail.com"

---

**¡Disfruta del Quiz!** 🎉