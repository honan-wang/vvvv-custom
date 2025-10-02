const fs = require('fs');

console.log('开始最终修复...');

// 读取文件
let content = fs.readFileSync('declaration.js', 'utf8');

// 替换有问题的行
console.log('修复第50行...');
content = content.replace(
  /mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?,/g,
  "mainGoods: 'Chemical materials and plastic products',"
);

console.log('修复第59行...');
content = content.replace(
  /mainGoods: '绾虹粐鍝併€侀瀷绫?,/g, 
  "mainGoods: 'Textile and shoes',"
);

console.log('修复第68行...');
content = content.replace(
  /mainGoods: '椋熷搧銆侀ギ鏂?,/g,
  "mainGoods: 'Food and beverages',"
);

// 修复第328行
console.log('修复第328行...');
content = content.replace(
  /\/\/ 鍒濆鍖栨柊鐢虫姤鍗\?\s+const initNewDeclaration/g,
  '// 鍒濆鍖栨柊鐢虫姤鍗?\n  const initNewDeclaration'
);

// 写入文件
fs.writeFileSync('declaration.js', content);

console.log('修复完成！');

// 验证语法
const { exec } = require('child_process');
exec('node -c declaration.js', (error, stdout, stderr) => {
  if (error) {
    console.error('语法检查失败:', error.message);
  } else {
    console.log('语法检查通过！');
  }
});