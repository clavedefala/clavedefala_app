import 'package:flutter/material.dart';

class ClaveTextField extends StatefulWidget {
  final Key key;
  final String initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle style;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final bool autovalidate;
  final bool maxLengthEnforced;
  final int maxLines;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final bool enabled;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final ValueChanged<String> onChanged;

  ClaveTextField(
      {this.key,
      this.initialValue,
      this.focusNode,
      this.decoration = const InputDecoration(),
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.style,
      this.textAlign = TextAlign.start,
      this.autofocus = false,
      this.obscureText = false,
      this.autocorrect = true,
      this.autovalidate = false,
      this.maxLengthEnforced = true,
      this.maxLines = 1,
      this.maxLength,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.enabled,
      this.keyboardAppearance,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.onChanged});

  @override
  _ClaveTextFieldState createState() => _ClaveTextFieldState();
}

class _ClaveTextFieldState extends State<ClaveTextField> {
  final TextEditingController _controller = new TextEditingController();

  _onChangedValue() {
    if (widget.onChanged != null) {
      widget.onChanged(_controller.text);
    }
  }

  @override
  void initState() {
    _controller.value = TextEditingValue(text: widget.initialValue);
    _controller.addListener(_onChangedValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChangedValue);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: _controller,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style,
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      autovalidate: widget.autovalidate,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
    );
  }
}
