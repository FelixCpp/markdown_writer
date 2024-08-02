extension type const Markdown(String value) implements String {}

extension StringToMarkdown on String {
  Markdown toMarkdown() => Markdown(this);
}
