requires 'perl', '5.014';

requires 'Text::ANSI::Fold', '2.2702';

on 'test' => sub {
    requires 'Text::VisualWidth::PP', '0.07';
    requires 'Test::More', '0.98';
};
