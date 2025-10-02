const fs = require('fs');

// 读取原文件
const originalContent = fs.readFileSync('declaration.js', 'utf8');

// 完整的修复内容
const fixedContent = originalContent
  .replace(
    "mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?,", 
    "mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?',"
  )
  .replace(
    "mainGoods: '绾虹粐鍝併€侀瀷绫?,", 
    "mainGoods: '绾虹粐鍝併€侀瀷绫?',"
  )
  .replace(
    "mainGoods: '椋熷搧銆侀ギ鏂?,", 
    "mainGoods: '椋熷搧銆侀ギ鏂?',"
  );

// 写入修复后的内容
fs.writeFileSync('declaration.js', fixedContent);

console.log('所有语法错误已修复完成');

// 验证修复结果
const lines = fixedContent.split('\n');
console.log('第48行:', lines[47]);
console.log('第57行:', lines[56]); 
console.log('第66行:', lines[65]);