import 'package:flutter/cupertino.dart';

class CustomCupertinoSearchTextField extends StatefulWidget {
  const CustomCupertinoSearchTextField({
    super.key,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.cursorColor,
    this.placeholder = 'Search',
  });

  final bool readOnly;
  final Color? cursorColor;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String placeholder;

  @override
  State<CustomCupertinoSearchTextField> createState() =>
      _CustomCupertinoSearchTextFieldState();
}

class _CustomCupertinoSearchTextFieldState
    extends State<CustomCupertinoSearchTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const BoxDecoration decoration = BoxDecoration(
      color: CupertinoColors.tertiarySystemFill,
      borderRadius: BorderRadius.all(Radius.circular(9.0)),
    );

    final IconThemeData iconThemeData = IconThemeData(
      color: CupertinoDynamicColor.resolve(
          CupertinoColors.secondaryLabel, context),
      size: 20,
    );

    final Widget prefix = Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(6, 0, 0, 3),
      child: IconTheme(
        data: iconThemeData,
        child: const Icon(CupertinoIcons.search),
      ),
    );

    return CupertinoTextField(
      decoration: decoration,
      prefix: prefix,
      keyboardType: TextInputType.text,
      onTap: widget.onTap,
      clearButtonMode: OverlayVisibilityMode.editing,
      placeholder: widget.placeholder,
      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
      padding: const EdgeInsetsDirectional.fromSTEB(5.5, 8, 5.5, 8),
      onChanged: widget.onChanged,
      autofocus: false,
      autocorrect: false,
      enableIMEPersonalizedLearning: true,
      textInputAction: TextInputAction.search,
      cursorColor: widget.cursorColor,
      readOnly: widget.readOnly,
      controller: controller,
    );
  }
}
