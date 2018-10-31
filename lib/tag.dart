import 'package:flutter/material.dart';

// Classe que define uma tag.
class Tag {
  Tag(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final int color;

  @override
  String toString() {
    return this.title;
  }
}

// Classe para criação de Widget que representa uma tag.
class TagItem extends StatelessWidget {
  const TagItem(this.tag);

  final Tag tag;

  Widget _buildTag() {
    return Container(
      child: Center(
        child: ListTile(
          leading: Icon(
            this.tag.icon,
            color: Colors.white,
          ),
          title: Text(
            this.tag.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Catamaran',
            ),
          ),
        ),
      ),
      color: Color(this.tag.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTag();
  }
}