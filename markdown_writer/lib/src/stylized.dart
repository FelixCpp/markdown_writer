import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

enum StyleType {
  asterisk,
  underscore,
}

abstract base class Stylized implements MarkdownEntry {
  const Stylized();

  const factory Stylized.bold(Markdown text, [StyleType type]) = _Bold;
  const factory Stylized.italic(Markdown text, [StyleType type]) = _Italic;
  const factory Stylized.boldItalic(Markdown text, [StyleType type]) =
      _BoldItalic;
  const factory Stylized.strikeThrough(Markdown text) = _Strikethrough;
  const factory Stylized.code(Markdown text) = _Code;
  const factory Stylized.codeblock(Markdown text, {String? language}) =
      _Codeblock;

  const factory Stylized.link({
    required Markdown text,
    required Uri url,
    String? tooltip,
  }) = _Link;

  const factory Stylized.image({
    required Markdown text,
    required Uri url,
    String? tooltip,
  }) = _Image;

  const factory Stylized.highlighted(Markdown text) = _Highlighted;
  const factory Stylized.subscribt(Markdown text) = _Subscribt;
  const factory Stylized.superscribt(Markdown text) = _Superscribt;
}

final class _Bold implements Stylized {
  final Markdown text;
  final StyleType type;

  const _Bold(this.text, [this.type = StyleType.asterisk]);

  @override
  Markdown toMarkdown() {
    return switch (type) {
      StyleType.asterisk => '**$text**',
      StyleType.underscore => '__${text}__'
    };
  }
}

final class _Italic implements Stylized {
  final Markdown text;
  final StyleType type;

  const _Italic(this.text, [this.type = StyleType.asterisk]);

  @override
  Markdown toMarkdown() {
    return switch (type) {
      StyleType.asterisk => '*$text*',
      StyleType.underscore => '_${text}_'
    };
  }
}

final class _BoldItalic implements Stylized {
  final Markdown text;
  final StyleType type;

  const _BoldItalic(this.text, [this.type = StyleType.asterisk]);

  @override
  Markdown toMarkdown() {
    return switch (type) {
      StyleType.asterisk => '***$text***',
      StyleType.underscore => '___${text}___'
    };
  }
}

final class _Strikethrough implements Stylized {
  final Markdown text;

  const _Strikethrough(this.text);

  @override
  Markdown toMarkdown() {
    return '~~$text~~';
  }
}

final class _Code implements Stylized {
  final Markdown text;

  const _Code(this.text);

  @override
  Markdown toMarkdown() {
    return '`$text`';
  }
}

final class _Codeblock implements Stylized {
  final Markdown text;
  final String? language;

  const _Codeblock(this.text, {this.language});

  @override
  Markdown toMarkdown() {
    return '```${language ?? ''}\n$text\n```';
  }
}

final class _Link implements Stylized {
  final Markdown text;
  final Uri url;
  final String? tooltip;

  const _Link({required this.text, required this.url, this.tooltip});

  @override
  Markdown toMarkdown() {
    final tooltipExtension = switch (tooltip) {
      String tooltip when tooltip.isNotEmpty => ' "$tooltip"',
      _ => ''
    };

    return '[$text$tooltipExtension]($url)';
  }
}

final class _Image implements Stylized {
  final Markdown text;
  final Uri url;
  final String? tooltip;

  const _Image({required this.text, required this.url, this.tooltip});

  @override
  Markdown toMarkdown() {
    final tooltipExtension = switch (tooltip) {
      String tooltip when tooltip.isNotEmpty => ' "$tooltip"',
      _ => ''
    };

    return '![$text$tooltipExtension]($url)';
  }
}

final class _Highlighted implements Stylized {
  final Markdown text;

  const _Highlighted(this.text);

  @override
  Markdown toMarkdown() {
    return '==$text==';
  }
}

final class _Subscribt implements Stylized {
  final Markdown text;

  const _Subscribt(this.text);

  @override
  Markdown toMarkdown() {
    return '~$text~';
  }
}

final class _Superscribt implements Stylized {
  final Markdown text;

  const _Superscribt(this.text);

  @override
  Markdown toMarkdown() {
    return '^$text^';
  }
}
